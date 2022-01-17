FactoryBot.define do
  factory :user do
    name { "テストユーザー" }
    email { "test@test.com" }
    password  { "password" }
    admin { 'true' }
  end
  factory :user_1, class: User do
    name { 'ユーザー1' }
    email{ 'user_1@test.com' }
    password { '111111' }
    admin {  'false'}
  end

  factory :user_2, class: User do
    name { '管理者' }
    email{ 'user_2@test.com' }
    password { '222222' }
    admin { 'true' }
  end
end
