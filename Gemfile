source 'http://rubygems.org'

gem 'rails', '3.0.0.beta3'

gem 'pg'

gem 'formtastic', :git => 'git://github.com/justinfrench/formtastic.git', :branch => 'rails3', :ref => '506182bcdb33637b53a8793bc33eff5abe53ba4c'
gem 'nifty-generators'

gem 'authlogic',          :git => 'git://github.com/odorcicd/authlogic.git', :branch => 'rails3'
gem 'bcrypt-ruby'

gem 'declarative_authorization', :git => 'git://github.com/stffn/declarative_authorization.git'
gem 'ruby_parser'

gem "will_paginate", :git => "http://github.com/mislav/will_paginate.git", :branch => "rails3"

#Heroku
gem 'aws-s3'
gem 'xml-simple'
gem 'mime-types'
gem 'builder'

group :test do
    gem 'factory_girl', :git => 'git://github.com/thoughtbot/factory_girl.git', :branch => 'rails3'
#    gem 'factory_girl_rails' # after beta3
    gem 'ffaker'

    gem 'rspec', '2.0.0.beta.11'

    gem 'autotest'
    gem 'autotest-rails'

    gem 'capybara'
    gem 'culerity'
    gem 'celerity', :require => nil

    gem 'database_cleaner'
    gem 'test-unit' # required for cucumber-rails until 0.3.1, see: https://rspec.lighthouseapp.com/projects/16211/tickets/588-no-such-file-to-load-testunittestresult
    gem 'cucumber'
    gem 'launchy'
    gem 'pickle', :git => 'git://github.com/codegram/pickle.git'
    # gem 'email_spec', :git => 'git://github.com/bmabey/email-spec.git', :branch => 'rails3'
    gem 'email_spec', :git => 'git://github.com/tjsingleton/email-spec.git', :branch => 'rails3'
end

group :development, :test do
  gem 'rspec-rails', '2.0.0.beta.11'
  gem 'cucumber-rails'

  gem 'ruby-debug19'      # does not support 1.9.2  
  gem 'ruby-debug-ide19'
end