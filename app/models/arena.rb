class Arena < ApplicationRecord
  include AASM

  has_many :arena_characters, dependent: :destroy
  has_many :arena_actions, through: :arena_characters

  enum state: { pending: 0, ready: 1, fighting: 2, ended: 3 }

  validates :size, numericality: { only_integer: true, greater_than_or_equal_to: 2 }

  aasm column: :state, enum: true, whiny_transitions: false, no_direct_assignment: true do
    state :pending, initial: true
    state :ready
    state :fighting
    state :ended

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

    event :fighting do
      transitions from: :ready, to: :fighting
    end

    event :ended do
      transitions from: :fighting, to: :ended
    end
  end
end
