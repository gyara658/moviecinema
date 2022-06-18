class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit]
  before_action :user_params, only: [:edit]

  def show
    @users = User.where(role: "user") if @user.role == "admin"
    @posts = Post.where(user_id: @user.id).order("created_at desc").where.not(image: nil)
  end

  def edit
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduce, :image)
  end
end
