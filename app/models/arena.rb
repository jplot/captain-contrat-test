class Arena < ApplicationRecord
  include AASM

  has_many :arena_characters

  enum state: { pending: 0, ready: 1 }

  aasm column: :state, enum: true, whiny_transitions: false, no_direct_assignment: true do
    state :pending, initial: true
    state :ready

    event :ready do
      transitions from: :pending, to: :ready do
        guard do
          self.arena_characters.map(&:ready?).reduce(:&)
        end
      end
    end
  end
end
