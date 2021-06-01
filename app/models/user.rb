class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendsses
  has_many :inverse_friendsses, class_name: 'Friendss', foreign_key: 'friend_id'
  has_many :confirmed_friendsses, -> { where confirmed: true }, class_name: 'Friendss'
  has_many :friends, through: :confirmed_friendsses
  has_many :pending_friendsses, -> { where confirmed: false }, class_name: 'Friendsses', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendsses, source: :friend
  has_many :inverted_friendsses, -> { where confirmed: false }, class_name: 'Friendsses', foreign_key: 'friend_id'
  has_many :friend_requests, through: :inverted_friendsses

  def friends
    friends_array = friendsses.map { |friendss| friendss.friend if friendss.confirmed }
    friends_array += inverse_friendsses.map { |friendss| friendss.user if friendss.confirmed }
    friends_array.compact
  end

  def pending_friends
    friendsses.map { |friendss| friendss.friend unless friendss.confirmed }.compact
  end

  def friend_requests
    inverse_friendsses.map { |friendss| friendss.user unless friendss.confirmed }.compact
  end

  def confirm_friend(user)
    friendss = inverse_friendsses.find { |f| f.user == user }
    friendss.confirmed = true
    friendss.save
  end

  def friend?(user)
    friends.include?(user)
  end

  def friends_and_own_posts
    Post.where(user: (friends.to_a << self))
  end
end
