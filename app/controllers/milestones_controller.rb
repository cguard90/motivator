class MilestonesController < ApplicationController

  def index
    @milestones =Milestone.joins(:events).where(goal_id: params[:id])
  end

  def show
    @milestone = Milestone.find_by(id: params[:id])
  end

  def create
    @milestone = Milestone.new(milestone_params)
    @milestone.goal = params[:id]
    if @milestone.save
    redirect goal_path ##TAKE ME TO PROFILE PAGE
  else
    render :new
  end
end

def edit
  @milestone.find_by(id: params[:id])
end

def update
  @milestone = Milestone.find_by(id: params[:id])
  if @milestone.update_attributes(milestone_params)
    redirect_to milestone_path
  else
    render :edit
  end

end

def destroy
  @milestone = Milestone.find_by(id: params[:id])
  @milestone.destroy
  redirect_to milestone_path
end

private

def milestone_params
  params.require(:milestone).permit(:goal_id,:description,:deadline)
end

end