class SessionsController < ApplicationController

    before_action :redirect_if_logged_in, only: [:create, :new]

    def new
        @user = User.new

        render :new
    end

    def create
        @user = User.find_by_credentials(
            params[:user][:username],
            params[:user][:password]
        )

        if @user
            login!(@user)
            redirect_to cats_url
        else
            flash.now[:errors] = ["incorrect credentials; try again"]
            render :new
        end
    end

    def destroy
        logout!

        redirect_to cats_url
    end
end
