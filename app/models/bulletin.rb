class Bulletin < ApplicationRecord
  include AASM

  belongs_to :user, dependent: :destroy
  belongs_to :category, dependent: :destroy
  has_one_attached :image, dependent: :destroy

  validates :name, presence: true, length: { maximum: 150 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, attached: true
  validates :category, presence: true

  default_scope { order('created_at DESC') }

  aasm whiny_transitions: false do
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
  end
end
