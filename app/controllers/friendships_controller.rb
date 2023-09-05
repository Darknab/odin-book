class FriendshipsController < ApplicationController
  before_action :set_friend, only: :destroy

  def index
    @friends = current_user.friends
    @not_friends = User.not_friends(current_user)
  end

  def destroy
    current_user.friends.destroy(@friend)
    @friend.friends.destroy(current_user)
    head :no_content
    redirect_to users_friendships_path(current_user)
  end

  private

  def set_friend
    @friend = current_user.friends.find(params[:id])
  end
end
