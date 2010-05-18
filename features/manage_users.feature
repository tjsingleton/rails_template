Feature: User management
  In order to manage
  As an admin
  I want to CRUD users

  Scenario:
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

