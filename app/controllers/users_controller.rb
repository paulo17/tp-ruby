class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      @users = User.all
      render :index
    end
  end

  def export
    render json: User.select(:id, :name, :email).all
  end

  private
  def user_params
    params[:user].permit(:name, :email)
  end

end
