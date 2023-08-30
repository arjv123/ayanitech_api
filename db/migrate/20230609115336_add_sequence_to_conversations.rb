class AddSequenceToConversations < ActiveRecord::Migration[7.0]
  def change
    add_column :conversations, :sequence, :bigint
    add_index :conversations, :sequence
  end
end
