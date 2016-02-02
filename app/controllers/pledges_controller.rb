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
    @goal = Goal.find_by(id: params[:goal_id])
    @pledge = Pledge.new
    if request.xhr?
      render layout: false
    end
  end

  def create
    @messages = Message.broadcast
    @pledge = Pledge.new(pledge_params)
    @pledge.goal = Goal.find_by(id: params[:goal_id])
    @pledge.user = current_user
    if @pledge.save
      @pledge.announce
      flash[:notice] = "#{@pledge.goal.setter.username} thanks you for the support"
      redirect_to new_charge_path(goal: @pledge.goal, amount: @pledge.amount)
    else
      @errors = @pledge.errors.full_messages
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
