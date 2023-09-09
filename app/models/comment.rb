class Comment < ApplicationRecord
  validates :body, presence: true
  
  belongs_to :user
  belongs_to :post
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :replies, class_name: 'Comment', foreign_key: 'parent_id'

  after_create :link_to_current_user

  private

  def after_create
    current_user.comments << @comment
  end
end
