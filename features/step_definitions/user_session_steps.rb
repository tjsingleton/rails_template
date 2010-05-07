Given /^a user with the email "([^"]+)"(?: and password "([^"]+)")?$/ do |email, password|
  password ||= "password"
  User.create(:email => email, :password => password, :password_confirmation => password)
end

Then /^I should be logged in as "([^\"]*)"$/ do |email|
  UserSession.find.user.email.should == email
end

When /^I log in as "([^\"]*)" and password "([^\"]*)"$/ do |email, password|
  password ||= "password"
  visit path_to('the login page')
  fill_in('user_session_email', :with => email)
  fill_in('user_session_password', :with => password)
  click_button('Login')
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

When /^I reset my password as "([^\"]*)" to password "([^\"]*)"(?: and confirmation "([^"]+)")?$/ do |email, password, confirmation|
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