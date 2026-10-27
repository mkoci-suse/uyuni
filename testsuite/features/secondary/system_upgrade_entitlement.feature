# Copyright (c) 2026 SUSE LLC.
# Licensed under the terms of the MIT license.

Feature: Upgrade a system entitlement
  This scenario verifies that a SUSE Linux Enterprise minion can be granted the
  monitoring entitlement. It checks that the entitlement is absent before the
  upgrade and is returned by the system's entitlement list afterward.

  @sle_minion
  Scenario: Add a monitoring entitlement to a system
    Given I want to operate on this "sle_minion"
    When I add the "monitoring_entitled" entitlement to "sle_minion"
    Then system "sle_minion" should have the "monitoring_entitled" entitlement
