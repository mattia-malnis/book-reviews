class AddRatingsAvgToBooks < ActiveRecord::Migration[7.2]
  def change
    add_column :books, :ratings_avg, :decimal, precision: 3, scale: 2
    Book.reset_column_information
    Book.all.find_each(&:cache_ratings_average)
  end
end
