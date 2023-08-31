class FiendshipRequestsController < ApplicationController
  before_action :set_friendship_request, except: [:index, :create]

  def create
    friend = User.find(params[:friend_id])
    @friendship_request = current_user.friend_requests.new(friend: friend)

    if @friendship_request.save
      render :show, status: :created, location: @friendship_request
    else
      render json: @friendship_request.errors, status: :unprocessable_entity
    end
  end

  def index
    @incoming = FiendshipRequest.where(friend: current_user)
    @outgoing = current_user.friendship_requests
  end

  def update
    @friendship_request.accept
    head :no_content
  end

  def destroy
    @friendship_request.destroy
    head :no_content
  end

  private

  def set_friendship_request
    @friendship_request = FiendshipRequest.find(params[:id])
  end
end
