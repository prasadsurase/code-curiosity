module Rescore
  extend ActiveSupport::Concern

  included do
    include AASM

    field :new_score,     type: Integer
    field :dev_comment,   type: String
    field :judge_comment, type: String
    field :aasm_state,    type: String

    aasm do
      state :new, initial: true
      state :submitted, :accepted, :rejected

      event :submit do
        transitions from: :new, to: :submitted
      end

      event :accept do
        transitions from: :submitted, to: :accepted
      end

      event :reject do
        transitions from: :submitted, to: :rejected
      end
    end
  end
end
