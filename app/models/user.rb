class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :username, length: { in: 3...16 }

  has_one_attached :avatar

  after_commit :add_default_avatar, on: [:create, :update]

  private

  def add_default_avatar
    avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'avatar_default.png')), filename: 'avatar_default.png', content_type: 'image/png') unless avatar.attached?
  end

  has_many :posts
end
