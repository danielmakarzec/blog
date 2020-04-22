require 'rails_helper'

RSpec.describe User, type: :model do

  # user 1
  let(:user1) { User.new(email: 'bob@mail.com', username: 'Bob', password: '123456', password_confirmation: '123456') }
  before { user1.save }

  # user 2
  let(:user2) { User.new(email: 'bill@mail.com', username: 'Bill', password: '123456', password_confirmation: '123456') }

  # User.username
  describe 'username' do

    it 'is required for every user' do
      user2.username = ''
      expect(user2).to be_invalid
    end

    it 'is unique for every user' do
      user2.username = 'Bob'
      expect(user2).to be_invalid
    end

    it 'is unique for every user (case insensitive)' do
      user2.username = 'bob'
      expect(user2).to be_invalid
    end

    it 'is minmum 3 chatacters long' do
      user2.username = 'Bo'
      expect(user2).to be_invalid
    end

    it 'is maximum 15 chatacters long' do
      user2.username = 'Braidonalexander'
      expect(user2).to be_invalid
    end
  end

  # User.email
  describe 'email' do
    it 'is required for every user' do
      user2.email = ''
      expect(user2).to be_invalid
    end

    it 'is unique for every user' do
      user2.email = 'bob@mail.com'
      expect(user2).to be_invalid
    end
  end

  # User.password
  describe 'password' do
    it 'is required for every user' do
      user2.password = ''
      expect(user2).to be_invalid
    end
  end

  # User.password_confirmation
  describe 'password' do
    it 'is required for every user' do
      user2.password_confirmation = ''
      expect(user2).to be_invalid
    end
  end
end
