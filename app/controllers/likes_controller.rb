class LikesController < ApplicationController
  before_action :find_likable

  def create
    if already_liked?
      flash[:notice] = "Already liked"
    else
      @likable.likes.create(user_id: current_user.id)
    end
    redirect_to @post
  end

  def destroy
    @like = @likable.likes.find_by(user_id: current_user.id)
    if already_liked?
      @like.destroy
    else
      flash[:notice] = "Cannot unlike"
    end
    redirect_to @post
  end

  private

  def find_likable
    if params[:likable_type] == "Post"
      @likable = Post.find(params[:likable_id])
      @post = @likable
    else
      @likable = Comment.find(params[:likable_id])
      @post = @likable.post
    end
  end

  def already_liked?
    current_user.likes.include?(@likable)
  end

end
