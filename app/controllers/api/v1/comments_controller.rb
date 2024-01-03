class Api::V1::CommentsController < ApplicationController
    before_action :find_post

    def index
        comments = @post.comments
        render json: comments, each_serializer: CommentSerializer
    end

    def create
        comment = @post.comments.new(comment_params)

        if comment.save
            render json: comment, serializer: CommentSerializer, status: :created
        else
            render json: {errors: comment.errors.messages}
        end
    end

    def update
        comment = @post.comments.find_by(id: params[:id])
        if comment.update(comment_params)
            render json: comment, serializer: CommentSerializer
        else
            render json: { errors: comment.errors.messages }, status: :unprocessable_entity
        end
    end

    def destroy
        comment = @post.comments.find_by(id: params[:id])
        if comment.destroy
            render json: { message: "Comment Deleted" }
        else
            render json: { errors: comment.errors.messages }, status: :unprocessable_entity
        end
    end

    def show
        comment = @post.comments.find_by(id: params[:id])
        if comment
            render json: comment, serializer: CommentSerializer
        else
            render json: {
                error: "Comment not found"
            }
        end
    end

    private

    def find_post
        @post = Post.find_by(id: params[:post_id]) 
        render json: { error: "Post not found" } unless @post
    end

    def comment_params
        params.require(:comment).permit(:name, :content, :likes)
    end
end
