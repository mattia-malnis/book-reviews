FactoryBot.define do
  factory :book do
    title { FFaker::Book.title }
    subtitle { FFaker::Lorem.sentence }
    ratings_avg { 0 }
  end
end
