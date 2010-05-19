class User < ActiveRecord::Base
  include User::Role
  self.per_page = 10

  acts_as_authentic do |c|
    c.login_field = 'email'
    c.crypto_provider = Authlogic::CryptoProviders::BCrypt
  end

end