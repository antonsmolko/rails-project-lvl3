# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bulletins, dependent: :destroy

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true

  paginates_per 20

  def full_name
    name
  end
end
