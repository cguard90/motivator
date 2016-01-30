class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.includes(:set_goals, :tended_goals).find_by(id: current_user.id)
    @pledges = @user.pledges.includes(:goal)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(id: @user.id)
    else
      flash[:notice] = "Invalid email or password"
      render new_user_path
    end
  end

  private

  def user_params
    user_params = params.require(:user).permit(:username, :email, :password)
  end

end