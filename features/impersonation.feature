Feature: Impersonation
  In order to access users accounts
  As an admin
  I want to impersonation other users

  Scenario: Logged in as a normal user
    Given a logged in user with the email "user@example.com"
    When I am on the new admin impersonation page
    Then I should be on the root page
    And I should see "Sorry, you not allowed to access that page" within "#flash_error"

  Scenario: No users to impersonate
    Given a logged in admin with the email "user@example.com"
    When I am on the new admin impersonation page
    Then I should be on the root page
    And I should see "No users to impersonate" within "#flash_notice"

  Scenario: Selecting a user to impersonate
    Given a logged in admin with the email "user@example.com"
    And a user with the email "target@example.com"
    When I am on the new admin impersonation page
    Then the "user_id" field should contain "target@example.com"

  Scenario: Starting a impersonation session
    Given a logged in admin with the email "user@example.com"
    And a user with the email "target@example.com"
    And I am on the new admin impersonation page
    When I press "Impersonate"
    Then I should be impersonating "target@example.com"

  Scenario: Viewing the account page while impersonating
    Given a logged in admin with the email "user@example.com"
    And a user with the email "target@example.com"
    And I am impersonating "target@example.com"
    When I go to the edit account page
    Then the "user_email" field should contain "target@example.com"
