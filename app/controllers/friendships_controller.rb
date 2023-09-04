class FriendshipsController < ApplicationController
  before_action :set_friend, only: :destroy

  def index
    @friends = current_user.friends
    @not_friends = User.not_friends(current_user)
  end

  def destroy
    current_user.remove_friend(@friend)
    @friend.remove_friend(current_user)
    head :no_content
  end

  private

  def set_friend
    @friend = current_user.friends.find(params[:id])
  end
end
