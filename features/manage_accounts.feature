Feature: Manage accounts
  In order to keep my information up to date
  As a user
  I want to manage the account

  Scenario: My Account
    Given a user with the email "user@example.com" and password "password"
    And I log in as "user@example.com" and password "password"
    When I go to the edit account page
    Then the "user_email" field should contain "user@example.com"

  Scenario: Create new account with required fields
    Given I am not registered
    When I register with the following:
      | email        | user@example.com |
      | password     | password         |
    Then I should see "Registration successful."
    And "user@example.com" should receive an email

  Scenario: Create new account with all fields
    Given I am not registered
    When I register with the following:
      | email        | user@example.com |
      | password     | password         |
    Then I should see "Registration successful."
    And "user@example.com" should receive an email

  Scenario: Create new account with mismatched password
    Given I am not registered
    When I register with the following:
      | email        | user@example.com |
      | password     | password         |
      | confirmation | badpass          |
    Then I should see "doesn't match confirmation"

  Scenario: Create new account with used email address
    Given a user with the email "user@example.com" and password "password"
    When I register with the following:
      | email        | user@example.com |
      | password     | password         |
    Then I should see "has already been taken"

  Scenario: Edit account to change email address
    Given a user with the email "user@example.com" and password "password"
    And I log in as "user@example.com" and password "password"
    When I update my email to "bob@example.com"
    Then I should see "Successfully updated profile."

  Scenario: Edit account to change email address to an existing email address
    Given a user with the email "user@example.com" and password "password"
    And a user with the email "bob@example.com" and password "password"
    And I log in as "user@example.com" and password "password"
    When I update my email to "bob@example.com"
    Then I should see "has already been taken"

  Scenario: Edit account to change password
    Given a user with the email "user@example.com" and password "password"
    And I log in as "user@example.com" and password "password"
    When I update my password to "newpass" and confirmation "newpass"
    Then I should see "Successfully updated profile."

  Scenario: Edit account to change password with mismatched password
    Given a user with the email "user@example.com" and password "password"
    And I log in as "user@example.com" and password "password"
    When I update my password to "newpass" and confirmation "badpass"
    Then I should see "doesn't match confirmation"
