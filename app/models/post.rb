class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :picture

  has_rich_text :body

  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, length: { in: 5...90 }

  def num_of_comments
    parent_coments = comments.count
    children_comments = 0
    comments.each do |comment|
      children_comments += comment.comments.count
    end
    parent_coments + children_comments
  end
end
