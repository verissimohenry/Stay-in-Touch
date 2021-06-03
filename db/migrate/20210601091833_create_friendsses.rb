class CreateFriendsses < ActiveRecord::Migration[5.2]
  def change
    create_table :friendsses do |t|
      t.bigint :user_id
      t.bigint :friend_id
      t.boolean :confirmed

      t.timestamps
    end
  end
end
