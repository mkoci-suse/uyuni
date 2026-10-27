When(/^I add the "([^"]*)" entitlement to "([^"]*)"$/) do |entitlement, hostname|
  system = $api_test.system.searchByName($session_key, hostname).find do |entry|
    entry['name'] == hostname
  end
  raise "Could not find system #{hostname}" unless system

  add_context(:system_upgrade_entitlement_system_id, system['id'])
  add_context(:system_upgrade_entitlement_label, entitlement)

  entitlements = $api_test.system.getEntitlements($session_key, system['id'])
  entitlements = entitlements.to_a.flatten if entitlements.is_a?(Hash)
  entitlement_labels = Array(entitlements).map { |label| label.to_s }
  expect(entitlement_labels).not_to include(entitlement)

  $api_test.system.upgradeEntitlement($session_key, system['id'], entitlement)
end

Then(/^system "([^"]*)" should have the "([^"]*)" entitlement$/) do |hostname, entitlement|
  expect(hostname).to eq('sle_minion')
  expect(entitlement).to eq(get_context(:system_upgrade_entitlement_label))

  system_id = get_context(:system_upgrade_entitlement_system_id)
  entitlements = $api_test.system.getEntitlements($session_key, system_id)
  entitlements = entitlements.to_a.flatten if entitlements.is_a?(Hash)
  entitlement_labels = Array(entitlements).map { |label| label.to_s }

  expect(entitlement_labels).to include(entitlement)
end
