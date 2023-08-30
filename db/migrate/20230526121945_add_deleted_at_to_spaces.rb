class AddDeletedAtToSpaces < ActiveRecord::Migration[7.0]
  def change
    add_column :spaces, :deleted_at, :datetime
    add_index :spaces, :deleted_at

    add_column :conversations, :deleted_at, :datetime
    add_index :conversations, :deleted_at
  end
end
