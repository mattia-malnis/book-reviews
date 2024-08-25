FactoryBot.define do
  factory :book do
    title { FFaker::Book.title }
    subtitle { FFaker::Lorem.sentence }
  end
end
