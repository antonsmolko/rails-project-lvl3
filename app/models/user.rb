# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :validatable, :trackable,
         :omniauthable, omniauth_providers: %i[github]

  has_many :bulletins, dependent: :destroy

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates :password, confirmation: { case_sensitive: true }

  paginates_per 20

  def self.from_omniauth(auth)
    exist_user = User.find_by(email: auth.info.email)

    if exist_user
      exist_user.provider = auth.provider
      exist_user.uid = auth.uid
      exist_user.save
      exist_user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.provider = auth.provider
        user.uid = auth.uid
        user.password = Devise.friendly_token[0, 20]
        user.first_name, user.last_name = auth.info.name.split
        user.skip_confirmation!
      end
    end
  end

  def admin?
    admin
  end

  def can_send_email?
    !email_disabled_delivery && !unconfirmed_email
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
