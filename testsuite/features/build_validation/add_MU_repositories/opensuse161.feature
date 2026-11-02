# Copyright (c) 2026 SUSE LLC
# SPDX-License-Identifier: MIT

@opensuse161
Feature: Add and synchronize Maintenance Update repositories for opensuse161

  Scenario: Add and synchronize Maintenance Update repositories for opensuse161
    Given I am authorized for the "Admin" section
    When I create the MU repositories for "opensuse161_minion"
    And I follow the left menu "Software > Manage > Channels"
    And I follow "Create Channel"
    And I enter "Custom Channel for opensuse161_minion" as "Channel Name"
    And I enter "custom_channel_opensuse161_minion" as "Channel Label"
    And I select the parent channel for the "opensuse161_minion" from "Parent Channel"
    And I enter "Custom channel" as "Channel Summary"
    And I click on "Create Channel"
    Then I should see a "Channel Custom Channel for opensuse161_minion created" text or "The channel label 'custom_channel_opensuse161_minion' is already in use" text
    When I follow the left menu "Software > Manage > Channels"
    And I enter "opensuse161_minion" as the filtered channel name
    And I click on the filter button
    And I follow "Custom Channel for opensuse161_minion"
    And I follow "Repositories" in the content area
    And I select the MU repositories for "opensuse161_minion" from the list
    And I click on "Save Repositories"
    Then I should see a "repository information was successfully updated" text
    When I follow the left menu "Software > Manage > Channels"
    And I enter "opensuse161_minion" as the filtered channel name
    And I click on the filter button
    And I follow "Custom Channel for opensuse161_minion"
    And I follow "Repositories" in the content area
    And I follow "Sync"
    And I wait until I do not see "Repository sync is running" text, refreshing the page
    And I wait until button "Sync Now" becomes enabled
    And I click on "Sync Now"
    Then I should see a "Repository sync scheduled" text or "No repositories are currently associated with this channel" text
    When I wait until the channel "custom_channel_opensuse161_minion" has been synced
    Then the "custom_channel_opensuse161_minion" reposync logs should not report errors
