class DropFollowing < ActiveRecord::Migration[5.2]
  def change
    drop_table :followings
  end
end
