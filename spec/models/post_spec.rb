require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.new(id: 1, email: 'bob@mail.com', username: 'Bob', password: '123456', password_confirmation: '123456') }
  before { user.save }
  let(:post) { Post.new(user_id: 1, title: 'abcde') }

  describe 'assosiations' do
    it 'belongs to user' do
      should respond_to(:user)
      end

    it 'was created by existing user' do
      post.user_id = ''
      expect(post).to be_invalid
    end
  end

  describe 'title' do

    it 'is minmum 5 chatacters long' do
      post.title = 'abcd'
      expect(post).to be_invalid
    end

    it 'is maximum 90 chatacters long' do
      title = ''
      90.times { title += 'a' }
      post.title = title
      expect(post).to be_invalid
    end

    it 'can be eg 9 chatacters long' do
      post.title = 'abcdefghi'
      expect(post).to be_valid
    end
  end
end
