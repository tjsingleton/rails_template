Feature: Manage User Sessions
  In order to provide authentication
  the user
  wants to manage his session

  Scenario: When I login
    Given a user with the email "user@example.com" and password "password"
    When I log in as "user@example.com" and password "password"
    Then I should be logged in as "user@example.com"
    And I should see "Login successful!"
    And I should see "Edit profile"
    And I should see "Logout"

  Scenario: When I login with bad info
    Given I am not registered
    When I log in as "user@example.com" and password "password"
    Then no one should be logged in
    And I should see "Please provide a valid email address and password."
    And I should not see "Logout"

  Scenario: When I logout
    Given a user with the email "user@example.com" and password "password"
    When I log in as "user@example.com" and password "password"
    And I go to the logout page
    Then no one should be logged in
    And I should see "Logout successful!"

  Scenario: When I request a password reset
    Given a user with the email "user@example.com" and password "password"
    When I request to reset my password as "user@example.com"
    Then "user@example.com" should receive an email

  Scenario: When I request a password reset with bad info
    Given I am not registered
    When I request to reset my password as "user@example.com"
    Then I should see "No user was found with that email address"

  Scenario: When I reset my password
    Given a user with the email "user@example.com" and password "password"
    When I reset my password as "user@example.com" to password "newpass"
    Then I should be logged in as "user@example.com"
    And I should see "Password successfully updated"

  Scenario: When I reset my password with a bad token
    Given I am not registered
    When I reset my password with a bad token
    Then I should see "We're sorry, but we could not locate your account"

  Scenario: When I reset my password mismatched passwords
    Given a user with the email "user@example.com" and password "password"
    When I reset my password as "user@example.com" to password "newpass" and confirmation "badpass"
    Then I should see "Password doesn't match confirmation"

  Scenario: On failed login my email address should be filled on the password reset page
    Given I log in as "user@example.com" and password "password"
    When I follow "Forgot your password?"
    Then the "email" field should contain "user@example.com"