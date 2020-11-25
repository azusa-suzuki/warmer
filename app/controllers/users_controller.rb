class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update]
  def show
    @user = User.find(params[:id])
    @invites = @user.invites.page(params[:page]).reverse_order
    @posts = @user.posts.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :handle_name, :profile, :prefecture, :email)
  end
end
