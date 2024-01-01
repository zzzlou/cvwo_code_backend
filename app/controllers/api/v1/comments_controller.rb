class Api::V1::CommentsController < ApplicationController
    def index
        comments=Comment.all
        render json: comments
    end

    def create
        comment=Comment.new(comment_params)

        if comment.save
            render json: comment, status: 200
        else
            render json:{
                errors:comment.errors.messages
            }
        end
    end

    def update
        comment = Comment.find_by(id: params[:id])
        if comment.update(comment_params)
            render json: comment
        else
            render json: { errors: comment.errors.messages }, status: 422
        end
    end

    def destroy
        comment = Comment.find_by(id: params[:id])
        if comment.destroy
            render json: "Comment Deleted"
        else
            render json: { errors: comment.errors.messages }, status: 422
        end
    end

    def show
        comment=Comment.find_by(id: params[:id])
        if comment
            render json: comment
        else
            render json:{
                error: "Comment not found"
            }
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:name,:content,:likes,:post_id)
    end
end