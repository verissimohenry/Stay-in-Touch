class Friendss < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  validates_presence_of :user_id, :friend_id

  def confirm_friend
    update_attributes(confirmed: true)
    Friendss.create!(friend_id: user_id,
                     user_id: friend_id,
                     confirmed: true)
  end
end
