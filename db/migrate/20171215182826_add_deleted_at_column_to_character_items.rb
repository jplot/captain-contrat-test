class AddDeletedAtColumnToCharacterItems < ActiveRecord::Migration[5.1]
  def change
    add_column :character_items, :deleted_at, :datetime
  end
end
