require 'rails_helper'

RSpec.describe Friendss, type: :model do
  context ' test friendss model' do
    before do
      @user = User.create(name: 'henry', email: 'verissimohenry04@gmail.com', password: '123456')
      @friend = User.create(name: 'tobi', email: 'tobi@gmail.com', password: '123456')
    end
    it 'return false if friend_id is not provided' do
      @invite = Friendss.create(user_id: @user.id)
      expect(@invite).to_not be_valid
    end
    it 'return false if user_id is not provided' do
      @invite = Friendss.create(friend_id: @friend.id)
      expect(@invite).to_not be_valid
    end

    it 'return true if user_id and friend_id got provided' do
      @invite = Friendss.create(user_id: @user.id, friend_id: @friend.id)
      expect(@invite).to be_valid
    end
  end
end
