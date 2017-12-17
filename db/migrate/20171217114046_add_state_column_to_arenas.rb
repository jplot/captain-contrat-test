class AddStateColumnToArenas < ActiveRecord::Migration[5.1]
  def change
    add_column :arenas, :state, :integer
  end
end
