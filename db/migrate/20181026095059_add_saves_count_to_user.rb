class AddSavesCountToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :saves_count, :integer
  end
end
