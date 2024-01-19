class Api::V1::SessionsController < ApplicationController
    def create
        user = User.find_by(username: params[:username])
        if user
          session[:user_id] = user.id
          render json: { logged_in: true, user: user }
        else
          render json: { error: 'Invalid username' }, status: :unauthorized
        end
    end
    
    def destroy
        session.delete(:user_id)
        render json: { logged_out: true }
    end

    def check_session #This is to re-fetch session from the backend to ensure that frontend does not lose login status upon refreshing of webpage
        if current_user
          render json: { logged_in: true, user: current_user.as_json(only: [:id, :username]) }
        else
          render json: { logged_in: false }
        end
    end
    private
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end
