class PostSerializer < ActiveModel::Serializer
    attributes :id, :title, :details, :category, :likes,:username, :user_id, :created_at, :updated_at, :comment_num
    def username
        object.user ? object.user.username : nil
    end
end