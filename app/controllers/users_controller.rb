class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update]

  def show
    @user = current_user

  end

  def edit
  end

  def update
    @user.update(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render :show
    end

  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :picture_url)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
