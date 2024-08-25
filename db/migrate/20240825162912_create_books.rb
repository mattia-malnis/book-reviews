class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :subtitle
      t.string :temp_image_url
      t.integer :external_ref
      t.virtual :textsearchable_col, type: :tsvector, as: "to_tsvector('english', title || ' ' || subtitle)", stored: true

      t.timestamps
    end

    add_index :books, :textsearchable_col, using: :gin
  end
end
