class AddMaxCharactersColumnToArenas < ActiveRecord::Migration[5.1]
  def change
    add_column :arenas, :min_characters, :integer, default: 2
    add_column :arenas, :max_characters, :integer, default: 2
  end
end
