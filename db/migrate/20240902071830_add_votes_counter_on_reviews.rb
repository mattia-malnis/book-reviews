class AddVotesCounterOnReviews < ActiveRecord::Migration[7.2]
  def change
    add_column :reviews, :like_count, :integer, default: 0
    add_column :reviews, :dislike_count, :integer, default: 0
  end
end
