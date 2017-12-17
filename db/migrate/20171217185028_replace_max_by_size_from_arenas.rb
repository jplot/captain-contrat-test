class ReplaceMaxBySizeFromArenas < ActiveRecord::Migration[5.1]
  def up
    add_column :arenas, :size, :integer, default: 2

    Arena.all.each do |arena|
      if arena.pending?
        arena.update(size: arena.max_characters)
      else
        arena.update(size: arena.arena_characters.count)
      end
    end

    remove_column :arenas, :min_characters, :integer
    remove_column :arenas, :max_characters, :integer
  end

  def down
    add_column :arenas, :min_characters, :integer, default: 2
    add_column :arenas, :max_characters, :integer, default: 2

    Arena.all.each do |arena|
      arena.update(min_characters: 2, max_characters: arena.size)
    end

    remove_column :arenas, :size, :integer
  end
end
