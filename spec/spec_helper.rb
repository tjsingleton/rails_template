# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.dirname(__FILE__) + "/../config/environment" unless defined?(Rails)
require 'rspec/rails'
require 'email_spec'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

ActiveRecord::TestCase.use_concurrent_connections

Rspec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # If you'd prefer not to run each of your examples within a transaction,
  # uncomment the following line.
  # config.use_transactional_examples = false

  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)
end

#----------------------------------------------------------------------------

# Note: Authentication is NOT ActiveRecord model, so we mock and stub it using RSpec.
def login(user_stubs = {}, session_stubs = {})
  User.current_user = @current_user = Factory(:user, user_stubs)
  @current_user_session = mock_model(UserSession, {:record => @current_user}.merge(session_stubs))
  UserSession.stub!(:find).and_return(@current_user_session)
  set_timezone
end

def logout
  @current_user = nil
  @current_user_session = nil
  UserSession.stub!(:find).and_return(nil)
end

#----------------------------------------------------------------------------

# Get current server timezone and set it (see rake time:zones:local for details).
def set_timezone
  offset = [ Time.now.beginning_of_year.utc_offset, Time.now.beginning_of_year.change(:month => 7).utc_offset ].min
  offset *= 3600 if offset.abs < 13
  Time.zone = ActiveSupport::TimeZone.all.select { |zone| zone.utc_offset == offset }.first
end

# Adjusts current timezone by given offset (in seconds).
def adjust_timezone(offset)
  if offset
    ActiveSupport::TimeZone[offset]
    adjusted_time = Time.now + offset.seconds
    Time.stub(:now).and_return(adjusted_time)
  end
end