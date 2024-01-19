class CommentSerializer < ActiveModel::Serializer
    attributes :id, :username, :user_id, :content, :likes, :post_id, :created_at, :updated_at
    def username
        object.user ? object.user.username : nil
    end

    def likes
        object.likes ? object.likes : 0
    end
end
  