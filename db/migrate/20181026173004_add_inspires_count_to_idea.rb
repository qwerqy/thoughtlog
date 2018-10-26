class AddInspiresCountToIdea < ActiveRecord::Migration[5.2]
  def change
    add_column :ideas, :inspires_count, :integer
  end
end
