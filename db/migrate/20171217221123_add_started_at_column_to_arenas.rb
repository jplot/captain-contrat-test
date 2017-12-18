class AddStartedAtColumnToArenas < ActiveRecord::Migration[5.1]
  def change
    add_column :arenas, :started_at, :datetime
  end
end
