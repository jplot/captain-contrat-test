class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.references :race, foreign_key: true

      t.timestamps
    end
  end
end
