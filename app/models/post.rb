class Post < ApplicationRecord
  belongs_to :user 
  has_many :comments, dependent: :destroy
  
  def comment_num
    comments.count
  end
end

  
