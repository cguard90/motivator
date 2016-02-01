class MilestonesController < ApplicationController
  respond_to :html, :js

  def index
    @milestones =Milestone.joins(:events).where(goal_id: params[:id])
    @messages = Message.broadcast
  end

  def show
    @milestone = Milestone.find_by(id: params[:id])
    @messages = Message.broadcast
  end

  def new
    @milestone = Milestone.new
  end

  def create
    @milestone = Milestone.new(milestone_params)
    @milestone.goal = params[:id]
    @messages = Message.broadcast
    if @milestone.save
      redirect goal_path ##TAKE ME TO PROFILE PAGE
    else
      render :new
    end
  end

  def edit
    @milestone = Milestone.find_by(id: params[:milestone_id])
    @goal = @milestone.goal
    @messages = @goal.messages.order(created_at: :desc)
    @setter = @milestone.goal.setter
    @tender = @milestone.goal.tender
  end

  def update
    @messages = Message.broadcast
    @milestone = Milestone.find_by(id: params[:id])
    @milestone.update_status(current_user)
    if @milestone.save
      @milestone.announcement
      redirect_to goal_path(id: params[:goal_id])
    else
      render :edit
    end
  end

  def destroy
    @messages = Message.broadcast
    @milestone = Milestone.find_by(id: params[:id])
    @milestone.destroy
    redirect_to milestone_path
  end

  private

  def milestone_params
    params.require(:milestone).permit(:goal_id,:description,:deadline)
  end

end
