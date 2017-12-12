class Asset < ApplicationRecord
  belongs_to :assetable, polymorphic: true

  enum slug: { vitality: 0, strength: 1, protection: 2 }
end
