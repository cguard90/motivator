class SessionsController < ApplicationController

  def new
    @messages = Message.broadcast
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(id: current_user.id)
    else
      flash[:notice] = "Invalid email or password"
      redirect_to new_session_path
    end
  end

  def oauth_create
    user = User.create_or_get_from_oauth(request.env['omniauth.auth'])
    if user
      session[:user_id] = user.id
      flash[:notice] = 'Login successful'
      redirect_to root_path
    else
      flash[:notice] = "Invalid Facebook Login"
      redirect_to new_session_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end