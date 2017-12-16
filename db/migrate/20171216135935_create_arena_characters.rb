class CreateArenaCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :arena_characters do |t|
      t.references :arena, foreign_key: true
      t.references :character, foreign_key: true

      t.timestamps
    end
  end
end
