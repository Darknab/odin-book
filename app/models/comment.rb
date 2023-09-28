class Comment < ApplicationRecord
  validates :body, presence: true
  
  belongs_to :user
  belongs_to :post
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :replies, class_name: 'Comment', foreign_key: 'parent_id', dependent: :destroy

  has_many :likes, as: :likable

  def liked_by?(user)
    likes = self.likes
    likes.where(user_id: user.id).exists?
  end
  
end
