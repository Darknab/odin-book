class FriendshipRequestsController < ApplicationController
  before_action :set_friendship_request, except: [:index, :create]

  def create
    friend = User.find(params[:friend_id])
    @friendship_request = current_user.friendship_requests.new(friend: friend)

    if @friendship_request.save
      redirect_to user_friendship_requests_path(current_user)
    else
      render json: @friendship_request.errors, status: :unprocessable_entity
    end
  end

  def index
    @incoming = FriendshipRequest.where(friend: current_user)
    @outgoing = current_user.friendship_requests
  end

  def update
    @friendship_request.accept
    # head :no_content
    redirect_to user_friendship_requests_path(current_user)
  end

  def destroy
    @friendship_request.destroy
    # head :no_content
    redirect_to user_friendship_requests_path(current_user)
  end

  private

  def set_friendship_request
    @friendship_request = FriendshipRequest.find(params[:id])
  end
end
