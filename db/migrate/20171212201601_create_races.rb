class CreateRaces < ActiveRecord::Migration[5.1]
  def change
    create_table :races do |t|
      t.string :slug

      t.timestamps
    end
    add_index :races, :slug, unique: true
  end
end
