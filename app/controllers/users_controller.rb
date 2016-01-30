class UsersController < ApplicationController

  def index
    @messages = Message.broadcast
    @users = User.all
  end

  def new
    @messages = Message.broadcast
    @user = User.new
  end

  def show
    @messages = Message.broadcast
    @user = User.includes(:set_goals, :tended_goals).find_by(id: params[:id])
    @pledges = @user.pledges.includes(:goal)
  end

  def create
    @messages = Message.broadcast
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