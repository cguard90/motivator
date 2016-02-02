class MilestonesController < ApplicationController

  def new
    @milestone = Milestone.new
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

end
