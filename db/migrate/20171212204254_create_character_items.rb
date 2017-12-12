class CreateCharacterItems < ActiveRecord::Migration[5.1]
  def change
    create_table :character_items do |t|
      t.references :character, foreign_key: true
      t.references :user_item, foreign_key: true

      t.timestamps
    end
  end
end
