class AddStateColumnToArenaCharacters < ActiveRecord::Migration[5.1]
  def change
    add_column :arena_characters, :state, :integer
  end
end
