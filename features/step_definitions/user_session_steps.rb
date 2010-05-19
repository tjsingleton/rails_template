Given /^a user with the email "([^"]+)"(?: and password "([^"]+)")?$/ do |email, password|
  password ||= "password"
  User.create(:email => email, :password => password, :password_confirmation => password, :approved => true)
end

When /^I log in as "([^\"]*)" and password "([^\"]*)"$/ do |email, password|
  password ||= "password"
  visit path_to('the login page')
  fill_in('user_session_email', :with => email)
  fill_in('user_session_password', :with => password)
  click_button('Login')
end

Given /^a logged in (user|admin) with the email "([^"]+)"(?: and password "([^"]+)")?$/ do |role, email, password|
  password ||= "password"
  steps %Q{
    Given a user with the email "#{email}" and password "#{password}"
    And I log in as "#{email}" and password "#{password}"
  }
  user = User.find_by_email email
  if role == "admin"
    user.replace_roles([:admin])
    user.save!
  end
end

Then /^I should be logged in as "([^\"]*)"$/ do |email|
  UserSession.find.user.email.should == email
end

Then /^no one should be logged in$/ do
  UserSession.find.should be_nil
end

Given /^I am not registered$/ do
  # empty
end

When /^I request to reset my password as "([^\"]*)"$/ do |email|
  visit path_to('the new password reset page')
  fill_in('email', :with => email)
  click_button('Reset my password')
end

When /^I reset my password as "([^\"]*)" to password "([^\"]*)"(?: and confirmation "([^\"]*)")?$/ do |email, password, confirmation|
  confirmation ||= password
  user = User.find_by_email email
  visit edit_password_reset_path(user.perishable_token)
  fill_in('user_password', :with => password)
  fill_in('user_password_confirmation', :with => confirmation)
  click_button("Update User")
end

When /^I reset my password with a bad token$/ do
  visit edit_password_reset_path("badtoken")
end

When /^I register as "([^\"]*)" with password "([^\"]*)"(?: and confirmation "([^\"]*)")?$/ do |email, password, confirmation|
  confirmation ||= password
  visit path_to('the new account page')
  fill_in('user_email', :with => email)
  fill_in('user_password', :with => password)
  fill_in('user_password_confirmation', :with => confirmation)
  click_button("Create User")
end

When /^I update my email (?:to|with) "([^\"]*)"$/ do |email|
  steps %Q{
    When I go to the edit account page
    And I fill in "Email" with "#{email}"
    And I press "Update User"
  }
end

When /^I update my password (?:to|with) "([^\"]*)" and confirmation "([^\"]*)"$/ do |password, confirmation|
  steps %Q{
    When I go to the edit account page
    And I fill in "Password" with "#{password}"
    And I fill in "Password confirmation" with "#{confirmation}"
    And press "Update User"
  }
end


