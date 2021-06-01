class AddIndexToFriendsses < ActiveRecord::Migration[5.2]
  def change
    add_index :friendsses, :friend_id
    add_index :friendsses, :user_id
  end
end
