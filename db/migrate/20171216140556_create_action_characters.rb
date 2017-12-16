class CreateActionCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :action_characters do |t|
      t.references :arena_action, foreign_key: true
      t.references :arena_character, foreign_key: true
      t.float :value

      t.timestamps
    end
  end
end
