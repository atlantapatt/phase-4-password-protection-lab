class UsersController < ApplicationController
    def create
            user = User.create(user_params)
            session[:user_id] ||= user.id
            if user.valid?
                render json: user, status: :created
            else
                render json: { error: "invalid entry" }, status: :unprocessable_entity
            end
            
    end

    def show
        user = User.find_by(id: session[:user_id])
        if user
            render json: user
        else
            render json: { error: "Invalid username or password" }, status: :unauthorized
        end
    end

    private
    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
