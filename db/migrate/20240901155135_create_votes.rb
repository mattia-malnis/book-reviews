class CreateVotes < ActiveRecord::Migration[7.2]
  def change
    create_table :votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :review, null: false, foreign_key: true
      t.integer :vote_type, null: false

      t.timestamps
    end

    add_index :votes, [ :user_id, :review_id ], unique: true
  end
end
