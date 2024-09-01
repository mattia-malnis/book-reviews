FactoryBot.define do
  factory :vote do
    vote_type { Vote.vote_types.keys.sample }
    user
    review
  end
end
