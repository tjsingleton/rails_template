require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Then(/^(.+?) should match route \/(.+?)$/) do |page, route|
  regexp = route.gsub(/:(\w*?)id/,'\d+')
  path_to(page).should =~ /#{regexp}/
end

Then(/^I should be at (.+)$/) do |page|
  URI.parse(current_url).path.should =~ /#{path_to(page)}/
end


Then /^the "([^\"]*)" value(?: within "([^\"]*)")? should (?:(not ))?be selected$/ do |label, selector, is_not|
  steps %Q{
    Then I should #{is_not}have xpath "#{selector}/option[@selected='selected'][@value='#{label}']"
  }
end

Then /^(?:|I )should have xpath "([^\"]*)"(?: within "([^\"]*)")?$/ do |xpath, selector|
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_xpath(xpath)
    else
      assert page.has_xpath?(xpath)
    end
  end
end

Then /^(?:|I )should not have xpath "([^\"]*)"(?: within "([^\"]*)")?$/ do |xpath, selector|
  with_scope(selector) do
    if page.respond_to? :should
      page.should_not have_xpath(xpath)
    else
      assert !page.has_xpath?(xpath)
   end
  end
end

Then /I should see the following within "([^"]+)" table/ do |css, expected_table|
  expected_table.diff! tableish("table#{css} tr", 'td,th')
end

Then /I am (?:in the )?debug(?:ger|ging)?/ do
  debugger
end

