# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  belongs_to :user, dependent: :destroy
  belongs_to :category, dependent: :destroy
  has_one_attached :image, dependent: :destroy

  validates :title, presence: true, length: { maximum: 150 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, attached: true
  validates :category, presence: true

  default_scope { order('created_at DESC') }

  paginates_per 20

  aasm column: 'state', whiny_transitions: false do
    state :draft, initial: true
    state :under_moderation, :published, :rejected, :archived

    event :to_moderate do
      transitions from: :draft, to: :under_moderation
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :archive do
      transitions from: %w[draft under_moderation published], to: :archived
    end

    event :to_draft do
      transitions from: %w[draft under_moderation published], to: :draft
    end
  end
end
