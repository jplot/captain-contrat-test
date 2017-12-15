class UserItem < ApplicationRecord
  belongs_to :user
  belongs_to :item

  has_one :character_item, dependent: :destroy

  def equip!(character)
    character.character_items.create(user_item: self)
  end
end
