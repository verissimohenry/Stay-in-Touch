class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @sent = Friendss.where(user_id: current_user.id).where(confirmed: nil)
    @pending = Friendss.where(friend_id: current_user.id).where(confirmed: nil)
  end
end
