class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field = 'email'
    c.crypto_provider = Authlogic::CryptoProviders::BCrypt
  end
  
  # Store current user in the class so we could access it from the activity observer without extra authentication query.
  cattr_accessor :current_user
  
  before_destroy :check_if_current_user
  
  private
  
  # Prevent current user from deleting herself.
  def check_if_current_user
    User.current_user && User.current_user != self
  end
  
end