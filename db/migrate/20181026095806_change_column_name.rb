class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :saves_count, :likes_count
    rename_column :projects, :saves_count, :likes_count
  end
end
