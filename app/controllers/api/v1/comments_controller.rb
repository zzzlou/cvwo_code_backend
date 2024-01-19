class Api::V1::CommentsController < ApplicationController
    before_action :find_post
    before_action :authenticate_user, only: [:create, :update, :destroy]

    def index
        comments = @post.comments
        render json: comments, each_serializer: CommentSerializer
    end

    def create
        comment = current_user.comments.new(comment_params.merge(post: @post))

        if comment.save
            render json: comment, serializer: CommentSerializer, status: :created
        else
            render json: {errors: comment.errors.messages}, status: :unprocessable_entity
        end
    end

    def update
        comment = @post.comments.find_by(id: params[:id])
        if comment && comment.user == current_user
            if comment.update(comment_params)
                render json: comment, serializer: CommentSerializer
            else
                render json: { errors: comment.errors.messages }, status: :unprocessable_entity
            end
        else
            render json: { error: "Not Authorized or Comment not found" }, status: :unauthorized
        end
    end

    def destroy
        comment = @post.comments.find_by(id: params[:id])
        if comment && comment.user == current_user
            if comment.destroy
                render json: { message: "Comment Deleted" }
            else
                render json: { errors: comment.errors.messages }, status: :unprocessable_entity
            end
        else
            render json: { error: "Not Authorized or Comment not found" }, status: :unauthorized
        end
    end

    def show
        comment = @post.comments.find_by(id: params[:id])
        if comment
            render json: comment, serializer: CommentSerializer
        else
            render json: { error: "Comment not found" }
        end
    end

    private

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def find_post
        @post = Post.find_by(id: params[:post_id]) 
        render json: { error: "Post not found" } unless @post
    end

    def authenticate_user
        render json: { error: 'Not Authorized' }, status: :unauthorized unless current_user
    end

    def comment_params
        params.require(:comment).permit(:name, :content, :likes)
    end
end
