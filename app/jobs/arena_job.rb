class ArenaJob < ApplicationJob
  queue_as :default

  def perform(arena_id)
    arena = Arena.find(arena_id)
    arena.fighting!

    characters = arena.arena_characters.map do |arena_character|
      Character.new(arena_character, arena)
    end

    loop do
      all_enemie_dead = false

      characters.each do |character|
        enemie = characters.reject { |c| c == character }.sample
        damage = (rand * character.attack).round(2) - enemie.defence
        damage = damage < 0 ? 0 : damage

        action = character.record.arena_actions.create(slug: 'attack')
        action.action_characters.create(arena_character: enemie.record, value: damage)
        character.health -= damage

        all_enemie_dead = characters.map { |c| c.health <= 0 }.count(false) == 1

        break if all_enemie_dead
      end

      break if all_enemie_dead
    end

    characters.each do |character|
      if character.health <= 0
        character.record.lose!
      else
        character.record.win!
      end
    end

    arena.ended!
  end

  class Character
    attr_reader :record, :assets, :attack, :defence
    attr_accessor :health

    def initialize(arena_character, arena)
      assets = arena_character.character.equipment_at(arena.started_at).flat_map do |character_item|
        character_item[:item].assets
      end
      assets += arena_character.character.race.assets

      @record = arena_character
      @assets ||= {}

      assets.each do |asset|
        @assets[asset.slug] ||= 0.0
        @assets[asset.slug] += asset.value
      end

      @health = (@assets['vitality'] || 0) * 0.6
      @attack = (@assets['strength'] || 0) * 0.2
      @defence = (@assets['protection'] || 0) * 0.14
    end
  end
end
