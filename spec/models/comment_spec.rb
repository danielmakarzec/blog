require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.new(id: 1, email: 'bob@mail.com', username: 'Bob', password: '123456', password_confirmation: '123456') }
  before { user.save }

  let(:post) { Post.new(id: 1, user_id: 1, title: 'abcde') }
  before { post.save }

  let(:comment) { Comment.new(user_id: 1) }

  describe 'assosiations' do
    it 'belongs to user' do
      should respond_to(:user)
      end

    it 'was created by existing user' do
      comment.commentable = post
      expect(comment).to be_valid
      comment.user_id = nil
      expect(comment).to be_invalid
    end
  end

  describe 'polymorphism' do
    context 'Comment of a post' do
      it {should respond_to(:commentable)}
    end

    context 'Reply to another comment' do
      it do
        comment.commentable = Comment.new
        should respond_to(:commentable)
      end
    end
  end
end
