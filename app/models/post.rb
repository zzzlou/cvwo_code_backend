class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
  
    def comment_num
      comments.count
    end
end
  
  
