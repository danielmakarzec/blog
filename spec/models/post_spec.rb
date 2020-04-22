require 'rails_helper'

RSpec.describe Post, type: :model do

  describe 'assosiations' do
    it 'belongs to user' do
      should respond_to(:user)
    end
  end
end
