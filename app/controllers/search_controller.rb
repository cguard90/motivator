class SearchController < ApplicationController
  def index
    @messages = Message.broadcast
    @results = search_all(params[:q])
  end

  private

  def search_all(params)

  end

end