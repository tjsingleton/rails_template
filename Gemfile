source 'http://rubygems.org'

gem 'rails', '3.0.0.beta3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'

gem 'formtastic', :git => "git://github.com/justinfrench/formtastic.git", :branch => 'rails3'
gem 'nifty-generators'

gem 'authlogic', :git => 'git://github.com/odorcicd/authlogic.git', :branch => 'rails3'
gem 'bcrypt-ruby'

#Heroku
gem 'aws-s3'
gem 'xml-simple'
gem 'mime-types'
gem 'builder'

group :test do
  gem 'factory_girl', :git => 'git://github.com/thoughtbot/factory_girl.git', :branch => 'rails3'
  gem 'ffaker'

  gem 'rspec'
  gem 'rspec-rails',      '>= 2.0.0.beta'
  gem 'autotest'
  gem 'autotest-rails'

  gem 'capybara'
  gem 'database_cleaner'
  gem 'test-unit'         # required for cucumber-rails until 0.3.1, see: https://rspec.lighthouseapp.com/projects/16211/tickets/588-no-such-file-to-load-testunittestresult
  gem 'cucumber-rails'
  gem 'cucumber',         '0.7.2'
  gem 'launchy'
  gem 'email_spec'

  gem 'spork'
  gem "hydra", :git => "git://github.com/albus522/hydra.git"
end

group :development, :test do
  gem 'wirble'
  gem 'ruby-debug19' # does not support 1.9.2
end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri', '1.4.1'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for certain environments:
# gem 'rspec', :group => :test
# group :test do
#   gem 'webrat'
# end

