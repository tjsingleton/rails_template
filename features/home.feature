Feature: Home page
  In order to access features of the site
  As a viewer
  I want to see links
  
  Scenario: Signed out links
    Given I am not registered
    When I go to the home page
    Then I should see "Register"
    And I should see "Login"
  