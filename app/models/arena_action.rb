class ArenaAction < ApplicationRecord
  belongs_to :arena_character

  enum slug: { attack: 0 }

  has_many :action_characters, dependent: :destroy
end
