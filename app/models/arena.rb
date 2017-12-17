class Arena < ApplicationRecord
  include AASM

  has_many :arena_characters, dependent: :destroy

  enum state: { pending: 0, ready: 1 }

  validates :size, numericality: { only_integer: true, greater_than_or_equal_to: 2 }

  aasm column: :state, enum: true, whiny_transitions: false, no_direct_assignment: true do
    state :pending, initial: true
    state :ready

    event :ready do
      transitions from: :pending, to: :ready do
        guard do
          state_characters = arena_characters.inside.map(&:ready?)
          state_characters.count >= size && state_characters.reduce(:&)
        end
      end

      after do
        update(started_at: Time.current)
      end
    end
  end
end
