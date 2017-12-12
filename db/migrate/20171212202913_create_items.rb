class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :slug
      t.text :slots

      t.timestamps
    end
    add_index :items, :slug, unique: true
  end
end
