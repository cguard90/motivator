class GoalsController < ApplicationController

def index
  @goals =Goal.all
end

def show
  @goal = Goal.find_by(id: params[:id])
end

def create
  @goal = Goal.new(goal_params)
  @goal.user = current_user
  if @goal.save
    redirect goal_path ##TAKE ME TO PROFILE PAGE
  else
    render :new
  end
end

def edit
  @goal.find_by(id: params[:id])
end

def update

end


def destroy

end

private

def goal_params
  params.require(:goal).permit(:title, :description, :limit, :charity_id) ##ASK STEVEN ABOUT USER_ID
end

end
