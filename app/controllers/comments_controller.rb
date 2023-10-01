class CommentsController < ApplicationController
  before_action :set_post, only: [:new, :create, :index]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(comment_params)

    @comment.user = current_user

    if @comment.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def index
    @comments = @post.comments.all
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(@comment.post)
    else 
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = @comment.post
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :image)
  end
end
