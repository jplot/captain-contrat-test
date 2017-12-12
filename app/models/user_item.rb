class UserItem < ApplicationRecord
  belongs_to :user
  belongs_to :item

  has_one :character_item, dependent: :destroy
end
