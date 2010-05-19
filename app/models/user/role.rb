module User::Role
  ROLES = {:guest => 1, :user => 2, :manager => 4, :admin => 8}.freeze

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
  def has_role?(role_sym)
    lookup_role_value(role_sym) & role_mask > 0
  end

  ##
  # Adds a role to a user. Accepts the same input as has_role?
  def add_role(role_sym)
    self.role_mask += lookup_role_value(role_sym)
    self
  end

  ##
  # Removes a role to a user. Accepts the same input as has_role?
  def remove_role(role_sym)
    self.role_mask -= lookup_role_value(role_sym)
    self
  end

  ##
  # Replaces current set of roles w\ ones from array
  def replace_roles(roles)
    self.role_mask = Array(roles).inject(0) {|accum, role| accum += lookup_role_value(role) }
    self
  end

  private
  def lookup_role_value(_role)
    case _role
      when Symbol then ROLES[_role]
      when String then ROLES[_role.to_sym]
      when 0 then raise(ArgumentError, "Role can't be 0")
      when nil then raise(ArgumentError, "Role can't be nil")
      else _role
    end
  end

end