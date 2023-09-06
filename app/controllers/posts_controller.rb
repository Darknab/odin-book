class PostsController < ApplicationController
  before_action :set_post only: [:show, :edit, :update, :destroy]
  before_action :authorise_user only: [:edit, :update, :destroy]

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to user_path(current_user)
    else
      render :new, status: :unpropcessable_entity
    end
  end

  def index
    @user = User.find(params[:id])
    @posts = @user.posts.all
  end

  def show
  end

  def edit
  end

  def update
    if @post.save
      redirect_to user_path(current_user)
    else
      render :edit, status: :unpropcessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to user_path(current_user), status: :see_other
  end

  private

  def set_post
    @post = Post.find(:id)
  end

  def authorise_user
    unless current_user == @post.user
      flash[:alert] = "You are not authorized to perfeorm this action."
      redirect_to root_path

  def post_params
    params.require(:post).permit(:body)
  end
end
