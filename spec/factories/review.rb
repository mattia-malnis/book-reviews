FactoryBot.define do
  factory :review do
    title { FFaker::Book.title }
    description { FFaker::Lorem.sentence }
    rating { (1..5).to_a.sample }
    user
    book
  end
end
