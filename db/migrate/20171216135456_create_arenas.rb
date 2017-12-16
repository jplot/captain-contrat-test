class CreateArenas < ActiveRecord::Migration[5.1]
  def change
    create_table :arenas do |t|

      t.timestamps
    end
  end
end
