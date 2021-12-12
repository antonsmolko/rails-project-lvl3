class Category < ApplicationRecord
  has_many :bulletins, dependent: :destroy

  validates :name, uniqueness: true, presence: true

  paginates_per 20
end
