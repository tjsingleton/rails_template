source 'http://rubygems.org'

gem 'rails', '3.0.0.beta3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'

gem 'formtastic',         :git => "git://github.com/justinfrench/formtastic.git", :branch => 'rails3'
gem 'nifty-generators'

gem 'authlogic',          :git => 'git://github.com/odorcicd/authlogic.git', :branch => 'rails3'
gem 'bcrypt-ruby'

gem 'declarative_authorization', :git => 'git://github.com/stffn/declarative_authorization.git'
#gem 'declarative_authorization', :git => 'git://github.com/tjsingleton/declarative_authorization.git'
#gem 'declarative_authorization',  :path => "~/Projects/Personal/declarative_authorization"
gem 'ruby_parser'

gem "will_paginate", :git => "http://github.com/mislav/will_paginate.git", :branch => "rails3"

#Heroku
gem 'aws-s3'
gem 'xml-simple'
gem 'mime-types'
gem 'builder'

group :test do
  gem 'factory_girl',     :git => 'git://github.com/thoughtbot/factory_girl.git', :branch => 'rails3'
  gem 'ffaker'

  gem 'rspec',            :git => 'git://github.com/rspec/rspec.git'
  gem 'rspec-rails',      :git => 'git://github.com/rspec/rspec-rails.git'
  gem 'rspec-core',       :git => 'git://github.com/rspec/rspec-core.git'
  gem 'rspec-expectations',       :git => 'git://github.com/rspec/rspec-expectations.git'
  gem 'rspec-mocks',       :git => 'git://github.com/rspec/rspec-mocks.git'
  gem 'autotest'
  gem 'autotest-rails'

  gem 'capybara'
  gem 'database_cleaner'
  gem 'test-unit'         # required for cucumber-rails until 0.3.1, see: https://rspec.lighthouseapp.com/projects/16211/tickets/588-no-such-file-to-load-testunittestresult
  gem 'cucumber-rails'
  gem 'cucumber',         '0.7.2'
  gem 'launchy'
  gem 'pickle',           :git => 'git://github.com/codegram/pickle.git'
  gem 'email_spec',       :git => 'git://github.com/bmabey/email-spec.git', :branch => 'rails3'

  gem 'spork'
  gem "hydra",            :git => "git://github.com/tjsingleton/hydra.git"
end

group :development, :test do
  gem 'wirble'
  gem 'hirb'
  gem 'ruby-debug19'      # does not support 1.9.2
end