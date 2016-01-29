class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      login @user
      redirect_to root_path
    else
      flash[:notice] = "Invalid email or password"
      redirect_to new_session_path
    end
  end

  def oauth_create
    user = User.create_or_get_from_oauth(request.env['omniauth.auth'])
    if user
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