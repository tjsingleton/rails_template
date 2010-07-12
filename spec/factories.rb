require 'ffaker'

Factory.sequence(:time) { |x| Time.now - x.hours }
Factory.sequence(:date) { |x| Date.today - x.days }
Factory.sequence(:number) { |n| n }

Factory.define :user do |u|
  u.sequence(:email)      { |n| "username#{n}@example.com" }
  u.password              "password"
  u.password_confirmation { |p| p.password }
  u.last_request_at     { Factory.next(:time) }
  u.current_login_at    { Factory.next(:time) }
  u.last_login_at       { Factory.next(:time) }
  u.last_login_ip       "127.0.0.1"
  u.current_login_ip    "127.0.0.1"
  u.login_count         { rand(100) + 1 }
  u.updated_at          { Factory.next(:time) }
  u.created_at          { Factory.next(:time) }
  u.role_mask           { User::ROLES[:user] }
end

Factory.define :guest, :parent => :user do |u|
  u.role_mask { User::ROLES[:guest] }
end

Factory.define :manager, :parent => :user do |u|
  u.role_mask { User::ROLES[:manager] }
end

Factory.define :admin, :parent => :user do |u|
  u.role_mask { User::ROLES[:admin] }
end