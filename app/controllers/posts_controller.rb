class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorise_user, only: [:edit, :update, :destroy]

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to post_path(@post)
    else
      render :new, status: :unpropcessable_entity
    end
  end

  def index
    @user = User.includes(friends: :posts).find(current_user.id)
    friend_post_ids = @user.friends.map { |friend| friend.posts.pluck(:id) }.flatten
    post_ids = @user.posts.pluck(:id) + friend_post_ids
    @posts = Post.find(post_ids)
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to user_path(current_user), status: :see_other
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorise_user
    unless current_user == @post.user
      flash[:alert] = "You are not authorized to perfeorm this action."
      redirect_to user_path(current_user)
    end
  end

  def post_params
    params.require(:post).permit(:body, :image)
  end
end
