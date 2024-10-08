FactoryBot.define do
  factory :user do
    nickname { FFaker::Internet.user_name }
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
  end
end
