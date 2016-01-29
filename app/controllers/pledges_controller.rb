class PledgesController < ApplicationController

  def index
    @pledge =Pledge.joins(:events).where(goal_id: params[:id])
  end

  def show
    @pledge = Pledge.find_by(id: params[:id])
  end

  def create
    @pledge = Pledge.new(pledge_params)
    @pledge.goal = params[:id]
    if @pledge.save
      redirect goal_path ##TAKE ME TO PROFILE PAGE
    else
      render :new
    end
  end

  def edit
    @milestone.find_by(id: params[:id])
  end

  private

  def pledge_params
    params.require(:pledge).permit(:goal_id,:amount)
  end

end
