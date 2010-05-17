Feature: Impersonation
  In order to access users accounts
  As a admin
  I want to impersonation other users

  Background:
    Given a logged in user with the email "user@example.com"

  Scenario: No users to impersonate
    When I am on the new impersonation page
    Then I should be on the root page
    And I should see "No users to impersonate" within "#flash_notice"

  Scenario: Selecting a user to impersonate
    Given a user with the email "target@example.com"
    When I am on the new impersonation page
    Then the "user_id" field should contain "target@example.com"

  Scenario: Starting a impersonation session
    Given a user with the email "target@example.com"
    And I am on the new impersonation page
    When I press "Impersonate"
    Then I should be impersonating "target@example.com"

  Scenario: Viewing the account page while impersonating
    Given a user with the email "target@example.com"
    And I am impersonating "target@example.com"
    When I go to the edit account page
    Then the "user_email" field should contain "target@example.com"
