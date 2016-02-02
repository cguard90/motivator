class MilestonesController < ApplicationController

  def new
    @milestone = Milestone.new
  end

  def edit
    @milestone = Milestone.find_by(id: params[:milestone_id])
    @goal = @milestone.goal
    @setter = @milestone.goal.setter
    @tender = @milestone.goal.tender
    @messages = @goal.load_news_feed
  end

  def update
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
