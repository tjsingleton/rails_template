class User < ActiveRecord::Base
  self.per_page = 10
  
  acts_as_authentic do |c|
    c.login_field = 'email'
    c.crypto_provider = Authlogic::CryptoProviders::BCrypt
  end

  has_many :roles

  ##
  # Array of the user's roles as symbols for use with declarative_authorization
  def role_symbols
    (roles || []).map {|r| r.title.to_sym}
  end

  before_destroy :check_if_current_user

  private

  # Prevent current user from deleting herself.
  def check_if_current_user
    @current_user && @current_user != self
  end
end