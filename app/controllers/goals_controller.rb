class GoalsController < ApplicationController

  def index
    @goals = Goal.all
    # Maybe apply batch
  end

  def new
    @goal = Goal.new
    @charities = Charity.all
    @milestones = Milestone.new
  end

  def show
    @goal = Goal.includes(:milestones,:messages).find_by(id: params[:id])
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.setter = current_user
    @goal.charity = Charity.find_by(name: params[:charity_selector])
    @goal.tender = User.find_by(username: params[:goal][:tender])
    if @goal.save
      @milestone = Milestone.new(milestone_params)
      redirect_to goal_path(id: @goal.id) if @milestone.save
    else
      render :new
    end
  end

  def edit
    @goal.find_by(id: params[:id])
  end

  def update
    @goal = Goal.find_by(id: params[:id])
    if @goal.update_attributes(goal_params)
      redirect_to goal_path
    else
      render :edit
    end
  end

  def destroy
    @goal = Goal.find_by(id: params[:id])
    @goal.destroy
    redirect_to goal_path
  end

private

  def goal_params
    params.require(:goal).permit(:title, :description, :limit)
  end

  def milestone_params
    {description: params[:goal][:milestones], goal_id: @goal.id, deadline: params[:Deadline] }
  end


end
