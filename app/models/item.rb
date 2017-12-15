class Item < ApplicationRecord
  has_many :item_slots, dependent: :destroy
  has_many :assets, as: :assetable, dependent: :destroy
  has_many :user_items, dependent: :destroy

  validates :slug, uniqueness: true
end
