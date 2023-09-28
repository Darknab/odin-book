class Post < ApplicationRecord
  validates :body, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likable

  def liked_by?(user)
    likes = self.likes
    likes.where(user_id: user.id).exists?
  end
end
