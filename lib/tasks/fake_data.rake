namespace :fake_data do
  desc "Create fake users"
  task :users, [ :count ] => :environment do |t, args|
    count = (args[:count] || 100).to_i

    puts "Creating #{count} users..."
    count.times do
      User.create({
        nickname: FFaker::Internet.user_name,
        email: FFaker::Internet.email,
        password: "12345678"
      })
    end
  end

  desc "Create fake reviews"
  task reviews: :environment do
    puts "Creating 50 reviews for each book (could take a while)"

    user_ids = User.pluck(:id)

    Book
    .left_outer_joins(:reviews)
    .where(reviews: { id: nil })
    .select(:id)
    .find_in_batches(batch_size: 50) do |book_batch|
      reviews = []
      book_batch.each do |book|
        50.times do
          reviews << {
            title: FFaker::Lorem.sentence.truncate(100, separator: " ", omission: ""),
            description: FFaker::Lorem.paragraph,
            rating: rand(1..5),
            user_id: user_ids.sample,
            book_id: book.id
          }
        end
      end

      Review.upsert_all(reviews)
      puts "Inserted #{reviews.size} reviews."
    end
    puts "Finished!"
  end
end
