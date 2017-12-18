class ArenaCharacter < ApplicationRecord
  include AASM

  belongs_to :arena
  belongs_to :character

  enum state: { pending: 0, ready: 1, left: 2, win: 3, lose: 4 }

  has_many :arena_actions, dependent: :destroy
  has_many :action_characters, dependent: :destroy

  scope :inside, -> { where.not(state: :leave) }

  validates :character, uniqueness: { scope: %i[arena character] }
  # validate :validate_place_available, on: :create

  aasm column: :state, enum: true, whiny_transitions: false, no_direct_assignment: true do
    state :pending, initial: true
    state :ready
    state :left
    state :win
    state :lose

    event :ready do
      transitions from: :pending, to: :ready

      after do
        arena.ready!
      end
    end

    event :pending do
      transitions from: :ready, to: :pending do
        guard do
          arena.pending?
        end
      end
    end

    event :leave do
      transitions from: %i[pending ready], to: :left do
        guard do
          arena.pending?
        end
      end
    end

    event :win do
      transitions from: :ready, to: :win
    end

    event :lose do
      transitions from: :ready, to: :lose
    end
  end

  # def validate_place_available
  #   if arena.arena_characters > arena.size
  #     errors.add(:max_characters)
  #   end
  # end
end
