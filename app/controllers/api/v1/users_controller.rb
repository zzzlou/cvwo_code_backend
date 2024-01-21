class Api::V1::UsersController < ApplicationController
  def index
    users = User.all
    render json: users
  end
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  def update
    user = User.find_by(id: params[:id])

    if user.update(user_params)
      render json: user
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show 
    user=User.find_by(id: params[:id])
    if user
      render json: user
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    user=User.find_by(id: params[:id])
    if user.destroy
        render json: { message: "User Deleted" }
    else
        render json: { errors: user.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
