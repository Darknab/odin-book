class User < ApplicationRecord
  # validates :user, presence: true
  # validates :friend, presence:true, uniqueness: {scope: :user}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]
  
  has_many :friendship_requests, dependent: :destroy
  has_many :pending_friendships, through: :friendship_requests, source: :friend

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :posts
  has_many :comments

  has_many :likes

  scope :not_friends, -> (user) { where.not(id: user.friends).where.not(id: user.friendship_requests).where.not(id: user.pending_friendships).where.not(id: user) }

end
