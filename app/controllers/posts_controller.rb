class PostsController < ApplicationController
  def index
    @user = User.find(author_id)
  end

  def show
    @post = Post.find(params[:id])
  end
  private
  def author_id
    params.require(:user_id)
  end
end
