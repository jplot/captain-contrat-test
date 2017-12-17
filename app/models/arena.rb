class Arena < ApplicationRecord
  include AASM

  has_many :arena_characters

  enum state: { pending: 0, ready: 1 }

  validates :min_characters, numericality: { only_integer: true, greater_than_or_equal_to: 2 }
  validates :max_characters, numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: 6  }

  aasm column: :state, enum: true, whiny_transitions: false, no_direct_assignment: true do
    state :pending, initial: true
    state :ready

    event :ready do
      transitions from: :pending, to: :ready do
        guard do
          state_characters = arena_characters.inside.map(&:ready?)
          state_characters >= min_characters && state_characters <= max_characters && state_characters.reduce(:&)
        end
      end
    end
  end
end
