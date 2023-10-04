class Post < ApplicationRecord
  validates :body, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likable

  has_one_attached :image

  # after_create_commit -> { broadcast_prepend_to "posts", partial: "posts/post", locals: { post: self, user: self.user } }
  # after_update_commit -> { broadcast_replace_to "posts", partial: "posts/post", locals: { post: self, user: self.user } }
  
  def liked_by?(user)
    Like.find_by(user_id: user.id, likable_id: self.id, likable_id: "post")
  end
  
end
