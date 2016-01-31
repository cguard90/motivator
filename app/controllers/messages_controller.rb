class MessagesController < ApplicationController

  def index
    @messages = Message.broadcast
  end

  def create
    if params[:goal_id]
      goal = Goal.find_by(id: params[:goal_id])
    else
      goal = Pledge.find_by(id: params[:pledge_id]).goal
    end
    @message = goal.messages.new(user: current_user, content: params[:message][:content])
    @message.save
    @messages = goal.messages
    redirect_to goal_path(id: goal.id)
  end

end