class CharacterItem < ApplicationRecord
  belongs_to :character
  belongs_to :user_item
end
