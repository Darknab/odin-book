class RepliesController < ApplicationController
  before_action :set_parent, only: [:new, :create]
  before_action :set_reply, only: [:show, :edit, :update, :destroy]

  def new
    @reply = @parent.replies.build
  end

  def create
    @reply = @parent.replies.build(reply_params)
    @reply.user = current_user
    @reply.post = @post

    if @reply.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @reply.update(reply_params)
      redirect_to post_path(@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = @reply.post
    @reply.destroy
    redirect_to post_path(@post)
  end

  private

  def set_parent
    @parent = Comment.find(params[:comment_id])
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end

  def set_reply
    @reply = Comment.find(params[:id])
  end

  def reply_params
    params.require(:comment).permit(:body, :parent_id)
  end
end