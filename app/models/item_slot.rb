class ItemSlot < ApplicationRecord
  belongs_to :item

  enum slug: { head: 0, chest: 1, right_hands: 2, left_hands: 3, leg: 4, foot: 5 }
end
