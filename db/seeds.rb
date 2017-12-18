# Races

race_human = Race.find_or_initialize_by(slug: 'human') do |race|
  race.save!

  race.assets.create!(slug: 'vitality', value: 7)
  race.assets.create!(slug: 'strength', value: 2)
end

race_dwarf = Race.find_or_create_by!(slug: 'dwarf') do |race|
  race.save!

  race.assets.create!(slug: 'vitality', value: 5)
  race.assets.create!(slug: 'strength', value: 3)
  race.assets.create!(slug: 'protection', value: 2)
end

race_ogre = Race.find_or_create_by!(slug: 'ogre') do |race|
  race.save!

  race.assets.create!(slug: 'vitality', value: 3)
  race.assets.create!(slug: 'strength', value: 5)
  race.assets.create!(slug: 'protection', value: 3)
end

# Basic Items

item_basic_sword = Item.find_or_create_by!(slug: 'basic-sword') do |item|
  item.save!

  item.assets.create!(slug: 'strength', value: 1)
  item.item_slots.create!(slug: 'right_hands')
end

item_basic_shield = Item.find_or_create_by!(slug: 'basic-shield') do |item|
  item.save!

  item.assets.create!(slug: 'protection', value: 1)
  item.item_slots.create!(slug: 'left_hands')
end

item_basic_hammer = Item.find_or_create_by!(slug: 'basic-hammer') do |item|
  item.save!

  item.assets.create!(slug: 'strength', value: 1)
  item.item_slots.create!(slug: 'right_hands')
  item.item_slots.create!(slug: 'left_hands')
end

item_basic_axe = Item.find_or_create_by!(slug: 'basic-axe') do |item|
  item.save!

  item.assets.create!(slug: 'strength', value: 1)
  item.item_slots.create!(slug: 'right_hands')
  item.item_slots.create!(slug: 'left_hands')
end

item_basic_helmet = Item.find_or_create_by!(slug: 'basic-helmet') do |item|
  item.save!

  item.item_slots.create!(slug: 'head')
end

item_basic_chestplate = Item.find_or_create_by!(slug: 'basic-chestplate') do |item|
  item.save!

  item.item_slots.create!(slug: 'chest')
end

item_basic_leggings = Item.find_or_create_by!(slug: 'basic-leggings') do |item|
  item.save!

  item.item_slots.create!(slug: 'leg')
end

item_basic_boots = Item.find_or_create_by!(slug: 'basic-boots') do |item|
  item.save!

  item.item_slots.create!(slug: 'foot')
end

# User test

unless User.exists?(email: 'test1@localhost')
  user_test_one = User.create!(email: 'test1@localhost', password: '0123456789')
  user_test_one_item_basic_sword = user_test_one.user_items.create!(item: item_basic_sword)
  user_test_one_item_basic_chestplate = user_test_one.user_items.create!(item: item_basic_chestplate)

  user_test_one_characters_one = user_test_one.characters.create!(race: race_human)
  user_test_one_characters_one.character_items.create!(user_item: user_test_one_item_basic_sword)
  user_test_one_characters_one.character_items.create!(user_item: user_test_one_item_basic_chestplate)
else
  user_test_one = User.find_by(email: 'test1@localhost')
  user_test_one_characters_one = user_test_one.characters[0]
end

unless User.exists?(email: 'test2@localhost')
  user_test_two = User.create!(email: 'test2@localhost', password: '0123456789')
  user_test_two_item_basic_sword = user_test_two.user_items.create!(item: item_basic_sword)
  user_test_two_item_basic_chestplate = user_test_two.user_items.create!(item: item_basic_chestplate)

  user_test_two_characters_one = user_test_two.characters.create!(race: race_human)
  user_test_two_characters_one.character_items.create!(user_item: user_test_two_item_basic_sword)
  user_test_two_characters_one.character_items.create!(user_item: user_test_two_item_basic_chestplate)
else
  user_test_two = User.find_by(email: 'test2@localhost')
  user_test_two_characters_one = user_test_two.characters[0]
end

arena = Arena.create!(size: 2)
arena.arena_characters.create!(character: user_test_one_characters_one).ready!
arena.arena_characters.create!(character: user_test_two_characters_one).ready!

ArenaJob.perform_now(arena.id)
