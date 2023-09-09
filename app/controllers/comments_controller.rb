class CommentsController < ApplicationController
  before_action :set_post, only: [:new, :create, :index]
  before_action :set_parent, only: [:new, :create]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def new
    if @parent
      @comment = @parent.replies.build
    else
      @comment = @post.comments.build
    end
  end

  def create
    if @parent
      @comment = @parent.replies.build
    else
      @comment = @post.comments.build
    end

    if @comment.save(comment_params)
      redirect_to post_path(@post)
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
      redirect_to post_path(@post)
    else 
      render :edit, status :unprocessable_entity
    end
  end

  def destroy
    @post = @comment.post
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_parent
    if params.includes?(parent_id)
      @parent = Comment.find(parent_id)
    end
  end

  def set_comment
    @comment = comment.find(params[:comment_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
