class Api::V1::SessionsController < ApplicationController
    def create
        Rails.logger.info "Session: #{session.inspect}"
        Rails.logger.info "Current User: #{current_user.inspect}"
        user = User.find_by(username: params[:username])
        if user
          session[:user_id] = user.id
          render json: { logged_in: true, user: user }
        else
          render json: { error: 'Invalid username' }, status: :unauthorized
        end
        Rails.logger.info "Session: #{session.inspect}"
        Rails.logger.info "Current User: #{current_user.inspect}"
    end
    
    def destroy
        session.delete(:user_id)
        render json: { logged_out: true }
    end
    private
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end
