# Copyright (c) 2026 SUSE LLC.
# Licensed under the terms of the MIT license.

Feature: Upgrade a system entitlement

  @sle_minion
  Scenario: Add a monitoring entitlement to a system
    Given I want to operate on this "sle_minion"
    When I call system.upgradeEntitlement() for "sle_minion" with "monitoring_entitled"
    Then system.getEntitlements() for "sle_minion" should include "monitoring_entitled"
