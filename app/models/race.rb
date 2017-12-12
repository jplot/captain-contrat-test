class Race < ApplicationRecord
  has_many :assets, as: :assetable, dependent: :destroy
  has_many :characters, dependent: :destroy

  validates :slug, uniqueness: true
end
