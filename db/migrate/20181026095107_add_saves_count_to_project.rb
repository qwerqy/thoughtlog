class AddSavesCountToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :saves_count, :integer
  end
end
