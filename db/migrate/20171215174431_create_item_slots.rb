class CreateItemSlots < ActiveRecord::Migration[5.1]
  def change
    create_table :item_slots do |t|
      t.references :item, foreign_key: true
      t.integer :slug

      t.timestamps
    end
  end
end
