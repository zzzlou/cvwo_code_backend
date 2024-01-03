class CommentSerializer < ActiveModel::Serializer
    attributes :id, :name, :content, :likes, :post_id, :created_at, :updated_at
end
  