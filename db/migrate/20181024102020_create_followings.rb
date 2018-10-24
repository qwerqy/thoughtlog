class CreateFollowings < ActiveRecord::Migration[5.2]
  def change
    create_table :followings do |t|
      t.integer :following_id
      t.integer :follower_id
      t.boolean :blocked

      t.timestamps
    end
  end
end
