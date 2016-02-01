class GoalsController < ApplicationController

  def index
    @messages = Message.broadcast
    @sorting_method = params[:sort]
    @goals = Goal.includes(:tender).all
    if @sorting_method == "Newest"
      @goals=@goals.sort_time
    elsif @sorting_method == "Submitted"
      @goals=@goals.sort_tender
    elsif @sorting_method == "Charity"
      @goals=@goals.sort_charity
    end
  end

  def new
    @messages = Message.broadcast
    @goal = Goal.new
    @charities = Charity.all
    @milestone = Milestone.new
  end

  def show
    binding.pry
    @goal = Goal.includes(:setter, :tender, :milestones, :messages, :pledges).find_by(id: params[:id])
    @milestones = @goal.milestones.order(:deadline)
    @message = Message.new
    @messages = @goal.messages.order(created_at: :desc)
    @errors = params[:errors]
  end

  def create
    @messages = Message.broadcast
    @goal = Goal.new(goal_params)
    @goal.setter = current_user
    @goal.charity = Charity.find_by(name: params[:charity_selector])
    @goal.tender = User.find_by(username: params[:goal][:tender])
    @mile_array = make_milestones(@goal)
    @mile_array.each do |milestone|
    if milestone.deadline && milestone.description && @goal.save
      @goal.announcement
      binding.pry
      milestone.goal_id = @goal.id
      milestone.save
    else
      @errors = @goal.errors.full_messages
      @errors.push("Milestones cannot be blank") if @milestone.description == nil
      @errors.push("Please select a deadline") if @milestone.deadline == nil
      @errors.push("That User cannot be found, please choose a different Goaltender") if @goal.tender == nil
      @goal = Goal.new(goal_params)
      @charities = Charity.all
      render :new
    end
    end
      redirect_to goal_path(id: @goal.id)
  end

  def edit
    @messages = Message.broadcast
    @goal = Goal.find_by(id: params[:id])
  end

  def update
    @messages = Message.broadcast
    @goal = Goal.find_by(id: params[:id])
    if @goal.update_attributes(goal_params)
      redirect_to goal_path
    else
      @errors = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find_by(id: params[:id])
    @goal.destroy
    redirect_to user_path(current_user)
  end

private

  def goal_params
    params.require(:goal).permit(:title, :description, :setter_pledge)
  end

  def milestone_params
    {description: params[:goal][:milestones], goal_id: @goal.id, deadline: params[:Deadline] }
  end

  def make_milestones(goal)
    milestone_array = []
    count = params[:milestone_count].to_i
     1.upto(count) do |n|
      description = params["mstone_m#{n}"]
      deadline = params["mstone_d#{n}"]
      milestone_array.push(Milestone.new(description: description, deadline: deadline))
    end
    return milestone_array
  end

end
