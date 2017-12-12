class Character < ApplicationRecord
  belongs_to :user
  belongs_to :race

  has_many :character_items, dependent: :destroy
end
