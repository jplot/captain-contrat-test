class CharacterItem < ApplicationRecord
  belongs_to :character
  belongs_to :user_item

  scope :currently_equipped, -> { where(deleted_at: nil) }
  scope :equipped_at, -> (timestamp = nil) {
    where(
      CharacterItem.arel_table[:deleted_at].gt(timestamp)
        .or(CharacterItem.arel_table[:deleted_at].eq(nil))
    ).where(CharacterItem.arel_table[:created_at].lteq(timestamp))
  }
  scope :by_slots, -> (slots) { includes(user_item: { item: :item_slots }).where(user_item: { item: { item_slots: { slug: slots } } }) }
  scope :by_slot, -> (slot) { by_slots([slot]) }

  def unequip!
    update(deleted_at: Time.current)
  end
end
