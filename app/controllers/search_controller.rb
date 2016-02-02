class SearchController < ApplicationController
  def index
    @messages = Message.broadcast
    @search_results = []
    search_deeper
    @search_results = @search_results.select { |thing| thing.class == User || thing.class == Goal || thing.class == Milestone || thing.class == Charity }
    @search_results.uniq!
  end

  private

  def search_deeper
    if params[:q].include?(" ")
      more_to_check = params[:q].split
      more_to_check.each do |word|
        milestone_include_search(word)
        charity_include_search(word)
        user_include_search(word)
        goal_include_search(word)
      end
    else
        milestone_include_search(params[:q])
        charity_include_search(params[:q])
        user_include_search(params[:q])
        goal_include_search(params[:q])
    end
  end

  def milestone_include_search(word)
    Milestone.all.each do |milestone|
      if milestone.description.include?(word) || milestone.description.include?(word.capitalize)
        @search_results.push(milestone)
      end
    end
  end

  def goal_include_search(word)
    Goal.all.each do |goal|
      if goal.title.include?(word) || goal.title.include?(word.capitalize)
        @search_results.push(goal)
      elsif goal.description.include?(word)
        @search_results.push(goal)
      end
    end
  end

  def charity_include_search(word)
    Charity.all.each do |charity|
      if charity.name.include?(word.upcase)
        @search_results.push(charity)
      elsif charity.category.include?(word) || charity.category.include?(word.capitalize)
        @search_results.push (charity)
      end
    end
  end

  def user_include_search(word)
    User.all.each do |user|
      if user.username.include?(word) || user.username.include?(word.capitalize)
        @search_results.push(user)
      elsif user.email.include?(word)
        @search_results.push(user)
      end
    end
  end
end