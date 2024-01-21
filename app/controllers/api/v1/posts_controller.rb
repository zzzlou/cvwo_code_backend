class Api::V1::PostsController < ApplicationController
    before_action :set_post, only: [:update, :destroy, :show]
    before_action :authenticate_user, only: [:create, :update, :destroy]

    def index
        if params[:category]
          posts = Post.where(category: params[:category])
        else
          posts = Post.all
        end
        render json: posts, each_serializer: PostSerializer
      end

    def create
        post = current_user.posts.new(post_params)

        if post.save
            render json: post, serializer: PostSerializer
        else
            render json: { errors: @post.errors.messages }, status: :unprocessable_entity
        end
    end

    def update
        if @post.update(post_params)
            render json: @post, serializer: PostSerializer
        else
            render json: { errors: @post.errors.messages }, status: :unprocessable_entity
        end
    end

    def destroy
        if @post.user == current_user || current_user.username == "admin"
            if @post.destroy
                render json: { message: "Post Deleted" }
            else
                render json: { errors: @post.errors.messages }, status: :unprocessable_entity
            end
        else
            render json: { error: "Not Authorized" }, status: :unauthorized
        end
    end

    def show
        render json: @post, serializer: PostSerializer
    end

    private
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def set_post
        @post = Post.find_by(id: params[:id])
        render json: { error: "Post not found" } unless @post
    end

    def authenticate_user
        
        render json: { error: 'Not Authorized' }, status: :unauthorized unless current_user
    end

    def post_params
        params.require(:post).permit(:title, :details, :category, :likes, :name)
    end
end
