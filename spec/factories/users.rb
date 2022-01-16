FactoryBot.define do
  factory :user do
    name { "テストユーザー" }
    email { "test@test.com" }
    password_digest { "password" }
    admin {'false'}
  end
end
