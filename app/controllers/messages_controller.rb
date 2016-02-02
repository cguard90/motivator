class MessagesController < ApplicationController

  def index
    @messages = Message.broadcast
  end

  def create
    goal = Goal.find_by(id: params[:goal_id])
    @message = goal.messages.new(user: current_user, content: params[:message][:content])
    if @message.save
      @messages = goal.messages
      redirect_to goal_path(id: goal.id)
    else
      @errors = @message.errors.full_messages
      redirect_to goal_path(id: goal.id, errors: @message.errors.full_messages)
    end
  end

end