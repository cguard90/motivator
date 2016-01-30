class PledgesController < ApplicationController

  def index
    @messages = Message.broadcast
    @pledge =Pledge.joins(:events).where(goal_id: params[:id])
  end

  def show
    @messages = Message.broadcast
    @pledge = Pledge.find_by(id: params[:id])
  end

  def new
    @messages = Message.broadcast
    @pledge = Pledge.new
  end

  def create
    @messages = Message.broadcast
    @pledge = Pledge.new(pledge_params)
    @pledge.goal = Goal.find_by(id: params[:goal_id])
    @pledge.user = current_user
      if @pledge.save
        flash[:notice] = "#{@pledge.goal.setter.username} thanks you for the support"
        redirect_to goal_path(@pledge.goal)
      else
        render :new
      end
  end

  def edit
    @messages = Message.broadcast
    @pledge.find_by(id: params[:id])
  end

  private

  def pledge_params
    params.require(:pledge).permit(:goal_id,:amount)
  end

end
