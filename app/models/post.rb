class Post < ApplicationRecord
  validates :body, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likable

  def liked_by?(user)
    Like.find_by(user_id: user.id, likable_id: self.id, likable_id: "post")
  end
end
