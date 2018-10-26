class CreateIdeas < ActiveRecord::Migration[5.2]
  def change
    create_table :ideas do |t|
      t.string :title
      t.string :description
      t.string :photo
      t.string :link

      t.timestamps
    end
  end
end
