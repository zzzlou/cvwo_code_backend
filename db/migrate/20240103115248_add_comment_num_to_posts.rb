class AddCommentNumToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :comment_num, :integer
  end
end
