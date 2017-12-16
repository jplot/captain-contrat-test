class CreateArenaActions < ActiveRecord::Migration[5.1]
  def change
    create_table :arena_actions do |t|
      t.references :arena_character, foreign_key: true
      t.string :slug

      t.timestamps
    end
  end
end
