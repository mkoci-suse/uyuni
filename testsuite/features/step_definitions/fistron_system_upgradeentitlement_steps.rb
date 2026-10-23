When(/^I call system\.upgradeEntitlement\(\) for "([^"]*)" with "([^"]*)"$/) do |hostname, entitlement|
  system = $api_test.system.searchByName($session_key, hostname).find do |entry|
    entry['name'] == hostname
  end
  raise "Could not find system #{hostname}" unless system

  @upgrade_entitlement_system_id = system['id']
  @upgrade_entitlement_label = entitlement

  entitlements = $api_test.system.getEntitlements(
    $session_key,
    @upgrade_entitlement_system_id
  )
  expect(Array(entitlements).map(&:to_s)).not_to include(entitlement)

  $api_test.system.upgradeEntitlement(
    $session_key,
    @upgrade_entitlement_system_id,
    entitlement
  )
end

Then(/^system\.getEntitlements\(\) for "([^"]*)" should include "([^"]*)"$/) do |hostname, entitlement|
  expect(hostname).to eq('sle_minion')
  expect(entitlement).to eq(@upgrade_entitlement_label)

  entitlements = $api_test.system.getEntitlements(
    $session_key,
    @upgrade_entitlement_system_id
  )
  labels = if entitlements.is_a?(Hash)
             entitlements.keys.map(&:to_s) + entitlements.values.map(&:to_s)
           else
             Array(entitlements).map(&:to_s)
           end

  expect(labels).to include(entitlement)
end
