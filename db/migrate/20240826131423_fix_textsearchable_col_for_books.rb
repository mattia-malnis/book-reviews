class FixTextsearchableColForBooks < ActiveRecord::Migration[7.2]
  def change
    # Remove the existing column
    remove_column :books, :textsearchable_col

    # Add the column back with the correct expression
    add_column :books, :textsearchable_col, :tsvector,
              as: "to_tsvector('english', COALESCE(title, '') || ' ' || COALESCE(subtitle, ''))",
              stored: true

    # Re-add the GIN index on the new column
    add_index :books, :textsearchable_col, using: :gin
  end
end
