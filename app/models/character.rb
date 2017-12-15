class Character < ApplicationRecord
  belongs_to :user
  belongs_to :race

  has_many :character_items, dependent: :destroy

  scope :active, -> { where(deleted_at: nil) }

  def current_equipment
    self.equipment
  end

  def equipment_at(timestamp)
    self.equipment(timestamp)
  end

  def archive!
    self.update(deleted_at: Time.current)
  end

  protected

  def equipment(timestamp = nil)
    equipped_items = timestamp ? self.character_items.equipped_at(timestamp) : self.character_items.currently_equipped
    equipped_items.includes(user_item: { item: :item_slots }).flat_map do |character_item|
      character_item.user_item.item.item_slots.map do |slot|
        {
          slot: slot.slug,
          item: character_item.user_item.item
        }
      end
    end
  end
end
