class AddForeignKeyToFriendsses < ActiveRecord::Migration[5.2]
  def change
  add_foreign_key "friendsses", "users"
  add_foreign_key "friendsses", "users", column: "friend_id"
  end
end
