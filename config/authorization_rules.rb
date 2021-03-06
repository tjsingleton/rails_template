authorization do
  role :guest do
  end

  role :user do
  end

  role :admin do
    has_permission_on :admin_impersonations, :to => :read
    has_permission_on :admin_users, :to => :read

    has_permission_on :authorization_rules, :to => :read
    has_permission_on :authorization_usages, :to => :read
  end
end