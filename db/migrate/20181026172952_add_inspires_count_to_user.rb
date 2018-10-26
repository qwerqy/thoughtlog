class AddInspiresCountToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :inspires_count, :integer
  end
end
