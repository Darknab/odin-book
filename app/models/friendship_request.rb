class FriendshipRequest < ApplicationRecord
validate :not_self
validate :not_friends
validate :not_pending

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def accept
    user.friends << friend
    friend.friends << user
    destroy
  end

  private

  def not_self
    errors.add(:friend, "can't be equal to user") if user == friend
  end

  def not_friends
    errors.add(:friend, 'is already added') if user.friends.include?(friend)
  end

  def not_pending
    errors.add(:friend, 'already requested friendship') if friend.pending_friendships.include?(user)
  end
end
