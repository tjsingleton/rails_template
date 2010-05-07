require 'ffaker'

Factory.sequence :time do |x|
  Time.now - x.hours
end

Factory.sequence :date do |x|
  Date.today - x.days
end

Factory.sequence(:number) { |n| n }

Factory.define :user do |u|
  u.sequence(:email)      { |n| "username#{n}@example.com" }
  u.password              "password"
  u.password_confirmation { |p| p.password }
  # u.first_name          { Faker::Name.first_name }
  # u.last_name           { Faker::Name.last_name }
  # u.title               { Factory.next(:title) }
  # u.company             { Faker::Company.name }
  # u.alt_email           { Faker::Internet.email }
  # u.phone                 { Faker::PhoneNumber.phone_number }
  # u.mobile              { Faker::PhoneNumber.phone_number }
  # u.aim                 nil
  # u.yahoo               nil
  # u.google              nil
  # u.skype               nil
  # u.admin               false
  # u.password_hash       "56d91c9f1a9c549304768982fd4e2d8bc2700b403b4524c0f14136dbbe2ce4cd923156ad69f9acce8305dba4e63faa884e61fb7a256cf8f5fc7c2ce176e68e8f"
  # u.password_salt       "ce6e0200c96f4dd326b91f3967115a31421a0e7dcddc9ffb63a77f598a9fcb5326fe532dbd9836a2446e46840d398fa32c81f8f4da1a0fcfe931989e9639a013"
  # u.persistence_token   "d7cdeffd3625f7cb265b21126b85da7c930d47c4a708365c20eb857560055a6b57c9775becb8a957dfdb46df8aee17eb120a011b380e9cc0882f9dfaa2b7ba26"
  # u.perishable_token    "TarXlrOPfaokNOzls2U8"
  u.last_request_at     { Factory.next(:time) }
  u.current_login_at    { Factory.next(:time) }
  u.last_login_at       { Factory.next(:time) }
  u.last_login_ip       "127.0.0.1"
  u.current_login_ip    "127.0.0.1"
  u.login_count         { rand(100) + 1 }
  # u.deleted_at          nil
  u.updated_at          { Factory.next(:time) }
  u.created_at          { Factory.next(:time) }
  # u.suspended_at        nil
end
