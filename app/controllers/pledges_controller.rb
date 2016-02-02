class PledgesController < ApplicationController

  def new
    @goal = Goal.find_by(id: params[:goal_id])
    @pledge = Pledge.new
    if request.xhr?
      render layout: false
    end
  end

  def create
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

  private

  def pledge_params
    params.require(:pledge).permit(:goal_id,:amount)
  end

end
