class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  has_one_attached :avatar
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  validates :username, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true

  mount_uploader :image, ImageUploader

  def email_required?
    false
  end
end
