class ArenaCharacter < ApplicationRecord
  include AASM

  belongs_to :arena
  belongs_to :character

  enum state: { pending: 0, ready: 1 }

  has_many :arena_actions
  has_many :action_characters

  validates :character, uniqueness: { scope: %i[arena character] }

  aasm column: :state, enum: true, whiny_transitions: false, no_direct_assignment: true do
    state :pending, initial: true
    state :ready

    event :ready do
      transitions from: :pending, to: :ready

      after do
        self.arena.ready!
      end
    end

    event :pending do
      transitions from: :ready, to: :pending do
        guard do
          self.arena.pending?
        end
      end
    end
  end
end
