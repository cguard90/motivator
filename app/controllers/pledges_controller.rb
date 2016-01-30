class PledgesController < ApplicationController

  def index
    @pledge =Pledge.joins(:events).where(goal_id: params[:id])
  end

  def show
    @pledge = Pledge.find_by(id: params[:id])
  end

  def new
    @pledge = Pledge.new
  end

  def create
    @pledge = Pledge.new(pledge_params)
    @pledge.goal = Goal.find_by(id: params[:goal_id])
    @pledge.user = current_user
      if @pledge.save
        redirect goal_path(@pledge.goal)
      else
        render :new
      end
  end

  def edit
    @pledge.find_by(id: params[:id])
  end

  private

  def pledge_params
    params.require(:pledge).permit(:goal_id,:amount)
  end

end
