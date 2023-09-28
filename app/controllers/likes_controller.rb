class LikesController < ApplicationController
  before_action :find_likable

  def create
    if @likable.liked_by?(current_user)
      flash[:notice] = "Already liked"
    else
      @likable.likes.create(user_id: current_user.id)
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = @likable.likes.find_by(user_id: current_user.id)
    if @likable.liked_by?(current_user)
      @like.destroy
    else
      flash[:notice] = "Cannot unlike"
    end
    redirect_back(fallback_location: root_path)
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

end
