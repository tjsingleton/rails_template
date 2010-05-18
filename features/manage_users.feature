Feature: User management
  In order to manage
  As an admin
  I want to CRUD users

  Scenario: Logged in as a normal user
    Given a logged in user with the email "user@example.com"
    When I am on the admin users page
    Then I should be on the root page
    And I should see "Sorry, you not allowed to access that page" within "#flash_error"

  Scenario: Viewing the index as an admin
    Given a logged in admin with the email "user@example.com"
    And the following users exist
       | email            |
       | test@example.com |
       | best@example.com |
       | west@example.com |
    When I am on the admin users page
    Then I should see "test@example.com"
    And I should see "best@example.com"
    And I should see "west@example.com"

  Scenario: Approving a user
    Given a logged in admin with the email "user@example.com"
    And the following users exist
       | email            | approved |
       | test@example.com | false    |
    When I am on the admin users page
    And I press "Approve"
    Then I should see "Successfully updated user." within "#flash_notice"
