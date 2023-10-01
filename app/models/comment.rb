class Comment < ApplicationRecord
  validates :body, presence: true
  
  belongs_to :user
  belongs_to :post
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :replies, class_name: 'Comment', foreign_key: 'parent_id', dependent: :destroy

  has_many :likes, as: :likable

  has_one_attached :image

  def liked_by?(user)
    Like.find_by(user_id: user.id, likable_id: self.id, likable_id: "Comment")
  end
  
end
