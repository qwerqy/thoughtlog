class RenameSavesToLikes < ActiveRecord::Migration[5.2]
  def change
    rename_table :saves, :likes
  end
end
