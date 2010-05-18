class User < ActiveRecord::Base
  self.per_page = 10

  ROLES = {:guest => 1, :user => 2, :admin => 4, :david => 8}.freeze

  acts_as_authentic do |c|
    c.login_field = 'email'
    c.crypto_provider = Authlogic::CryptoProviders::BCrypt
  end

  ##
  # Array of the user's roles as symbols for use with declarative_authorization
  def role_symbols
    ROLES.inject([]) do |accum, role|
      accum << role[0] if has_role?(role[1])
      accum
    end
  end

  ##
  # Bitwise comparison of role_mask with the supplied role. If role is passed in as a symbol or a string the integer
  # value is looked up in the ROLES hash
  def has_role?(_role)
    role = case _role
      when Symbol then ROLES[_role]
      when String then ROLES[_role.to_s]
      when 0 then raise ArgumentError("Role can't be 0")
      when nil then raise ArgumentError("Role can't be nil")
      else _role
    end
    role & self.role_mask > 0
  end
end