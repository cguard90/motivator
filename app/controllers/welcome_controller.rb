class WelcomeController < ApplicationController

  def index
    @messages = Message.broadcast
  end

end