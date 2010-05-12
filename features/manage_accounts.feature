Feature: Manage accounts
  In order to keep my information up to date
  a user
  wants to manage his account

  Scenario: My Account
    Given a user with the email "user@server.com" and password "password"
    And I log in as "user@server.com" and password "password"
    When I go to the edit account page
    Then the "user_email" field should contain "user@server.com"

  Scenario: Create new account
    Given I am not registered
    When I register as "user@server.com" with password "password"
    Then I should see "Registration successful."

  Scenario: Create new account with mismatched password
    Given I am not registered
    When I register as "user@server.com" with password "password" and confirmation "badpass"
    Then I should see "doesn't match confirmation"

  Scenario: Create new account with used email address
    Given a user with the email "user@server.com" and password "password"
    When I register as "user@server.com" with password "password"
    Then I should see "has already been taken"

  Scenario: Edit account to change email address
    Given a user with the email "user@server.com" and password "password"
    And I log in as "user@server.com" and password "password"
    When I update my email to "bob@server.com"
    Then I should see "Successfully updated profile."

  Scenario: Edit account to change email address to an existing email address
    Given a user with the email "user@server.com" and password "password"
    And a user with the email "bob@server.com" and password "password"
    And I log in as "user@server.com" and password "password"
    When I update my email to "bob@server.com"
    Then I should see "has already been taken"

  Scenario: Edit account to change password
    Given a user with the email "user@server.com" and password "password"
    And I log in as "user@server.com" and password "password"
    When I update my password to "newpass" and confirmation "newpass"
    Then I should see "Successfully updated profile."

  Scenario: Edit account to change password with mismatched password
    Given a user with the email "user@server.com" and password "password"
    And I log in as "user@server.com" and password "password"
    When I update my password to "newpass" and confirmation "badpass"
    Then I should see "doesn't match confirmation"
