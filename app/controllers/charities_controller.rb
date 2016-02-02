class CharitiesController < ApplicationController

  def index
    @charities =Charity.all
  end

  def show
    @charity = Charity.find_by(id: params[:id])
  end

end
