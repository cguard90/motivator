class GoalsController < ApplicationController

  def index
    @sorting_method = params[:sort]
    @goals = Goal.all
    if @sorting_method == "Newest"
      @goals = Goal.sort_time
    elsif @sorting_method == "Submitted"
      @goals = Goal.sort_setter
    elsif @sorting_method == "Charity"
      @goals = Goal.sort_charity
    else
      @goals = Goal.sort_time
    end
  end

  def new
    @goal = Goal.new
    @charities = Charity.all
    @milestone = Milestone.new
  end

  def show
    @goal = Goal.includes(:setter, :tender, :milestones, :messages, :pledges).find_by(id: params[:id])
    @milestones = @goal.milestones.order(:deadline)
    @total_value = @goal.total_milestone_value
    @completed = @goal.total_milestone_value_completed
    @message = Message.new
    @messages = @goal.load_news_feed
    @errors = params[:errors]
  end

  def create
    @goal = Goal.new(goal_params)
    @charities = Charity.all
    mile_value = (100/(params[:milestone_count].to_i).round)
    mile_array = make_milestones(@goal,mile_value)
    mile_array.each do |milestone|
      unless milestone.deadline && milestone.description
        @errors = @goal.errors.full_messages
        @errors.push("Milestones cannot be blank") if milestone.description == nil
        @errors.push("Please select a deadline") if milestone.deadline == nil
      end
    end
    if @goal.save
      @goal.announce
      GoalMailer.invite_tender_email(@goal).deliver_now
      redirect_to goal_path(id: @goal.id)
    else
      @errors = @goal.errors.full_messages
      @errors.push("That user cannot be found, please choose a different Goaltender") if !goal_params[:tender]
      binding.pry
      render :new
    end
  end

  def edit
    @goal = Goal.includes(:tender).find_by(id: params[:id])
    @messages = @goal.load_news_feed
  end

  def update
    @goal = Goal.find_by(id: params[:id])
    if @goal.update_attributes(title: params[:goal][:title], description: params[:goal][:description])
      redirect_to goal_path
    else
      @errors = @goal.errors.full_messages
      render :edit
    end
  end

private

  def goal_params
    params.require(:goal).permit(:title, :description, :setter_pledge).merge(
      setter:current_user,
      charity: Charity.find_by(name: params[:charity_selector]),
      tender: User.find_by(username: params[:goal][:tender])
      )
  end

  def make_milestones(goal,value)
    milestone_array = []
    count = params[:milestone_count].to_i
     1.upto(count) do |n|
      description = params["mstone_m#{n}"]
      deadline = params["mstone_d#{n}"]
      milestone_array.push(goal.milestones.build(description: description, deadline: deadline, value: value))
    end
    return milestone_array
  end

end
