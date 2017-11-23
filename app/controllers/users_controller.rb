class UsersController < ApplicationController
  load_resource find_by: :slug
  authorize_resource

  def index
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user.save!

    render json: @user, status: 201
  end

private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
