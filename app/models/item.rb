class Item < ApplicationRecord
  has_many :assets, as: :assetable, dependent: :destroy
  has_many :user_items, dependent: :destroy

  serialize :slots, Array

  validates :slug, uniqueness: true
  validates :slots, inclusion: { in: %w[head chest right_hands left_hands leg foot] }
end
