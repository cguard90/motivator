class MessagesController < ApplicationController

  def index
    @messages = Message.broadcast
  end

end