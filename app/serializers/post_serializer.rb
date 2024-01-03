class PostSerializer < ActiveModel::Serializer
    attributes :id, :title, :details, :category, :likes, :name, :created_at, :updated_at, :comment_num
end