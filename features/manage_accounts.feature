Feature: Manage accounts
  In order to keep my information up to date
  a user
  wants to manage his account

  # Placeholder story until I figure out what I plan on doing.  
  Scenario: My Account
    Given a user with the email "user@server.com" and password "password"
    And I log in as "user@server.com" and password "password"
    When I am on the account page
    Then I should see "user@server.com"