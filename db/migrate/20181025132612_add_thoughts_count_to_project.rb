class AddThoughtsCountToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :thoughts_count, :integer
  end
end
