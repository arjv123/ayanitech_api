class AddMaxTokensToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :max_tokens, :integer, default: 300
    add_column :users, :timeout, :integer, default: 30
  end
end
