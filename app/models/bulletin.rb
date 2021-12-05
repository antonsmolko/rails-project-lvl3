class Bulletin < ApplicationRecord
  belongs_to :creator, class_name: 'User', dependent: :destroy
  belongs_to :category, dependent: :destroy
  has_one_attached :image, dependent: :destroy

  validates :name, presence: true, length: { maximum: 150 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, attached: true
  validates :category, presence: true

  default_scope { order('created_at DESC') }
end
