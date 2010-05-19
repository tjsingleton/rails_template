Then /^I should be impersonating "([^\"]*)"$/ do |email|
  UserSession.find(:impersonation).user.email.should == email
end

When /^I am impersonating "([^\"]*)"$/ do |email|
  steps %Q{
    And I am on the new admin impersonation page
    When I select "#{email}" from "user_id"
    And I press "Impersonate"
  }
end