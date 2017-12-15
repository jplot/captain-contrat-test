class RemoveSlotsColumnFromItems < ActiveRecord::Migration[5.1]
  def change
    remove_column :items, :slots, :text
  end
end
