class AddDeletedAtColumnToCharacters < ActiveRecord::Migration[5.1]
  def change
    add_column :characters, :deleted_at, :datetime
  end
end
