class Api::V1::PostsController < ApplicationController
    def index
        posts=Post.all
        render json: posts, each_serializer: PostSerializer

    end

    def create
        post=Post.new(post_params)

        if post.save
            render json: post, serializer: PostSerializer
        else
            render json:{
                error:"An error has occurred"
            }
        end
    end

    def update
        post = Post.find_by(id: params[:id])
        if post.update(post_params)
            render json: post, serializer: PostSerializer
        else
            render json: { errors: post.errors.messages }, status: 422
        end
    end

    def destroy
        post = Post.find_by(id: params[:id])
        if post.destroy
            render json: "Post Deleted"
        else
            render json: { errors: post.errors.messages }, status: 422
        end
    end

    def show
        post=Post.find_by(id: params[:id])
        if post
            render json: post, serializer: PostSerializer
        else
            render json:{
                error: "Post not found"
            }
        end
    end

    private

    def post_params
        params.require(:post).permit(:title,:details,:category,:likes,:name)
    end
end
