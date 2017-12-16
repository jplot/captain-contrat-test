class ActionCharacter < ApplicationRecord
  belongs_to :arena_action
  belongs_to :arena_character
end
