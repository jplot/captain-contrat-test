class CreateAssets < ActiveRecord::Migration[5.1]
  def change
    create_table :assets do |t|
      t.references :assetable, polymorphic: true
      t.integer :slug
      t.float :value

      t.timestamps
    end
  end
end
