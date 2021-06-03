class FriendssesController < ApplicationController
  def create
    @user = User.find(params[:format])
    @friendss = current_user.friendsses.create(friend_id: params[:format])
    @friendss.save
    redirect_back(fallback_location: root_path)
  end

  def update
    @friendss = Friendss.find(params[:id])
    @friendss.confirmed = true
    @friendss.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @friendss = Friendss.find(params[:id])
    @friendss.destroy
    redirect_back(fallback_location: root_path)
  end
end
