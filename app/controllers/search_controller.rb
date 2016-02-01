class SearchController < ApplicationController
  def index
    @messages = Message.broadcast
    @results = []
    @secondary_search = []
    search_users(params[:q])
    search_charities(params[:q])
    search_goals(params[:q])
    search_milestones(params[:q])
    search_deeper
    @results = @results.select { |thing| thing.class == User || thing.class == Goal || thing.class == Milestone || thing.class == Charity }
  end

  private

  def search_users(arg)
    user_fields = [:id, :username, :email]
    user_fields.each do |field|
      if User.find_by(field => arg) || User.find_by(field => arg.capitalize) || User.find_by(field => arg.upcase) || User.find_by(field => arg.downcase)

        @results.push User.find_by(field => arg) || @results.push(User.find_by(field => arg.capitalize)) || @results.push(User.find_by(field => arg.upcase)) || @results.push(User.find_by(field => arg.downcase))
      end
    end
  end

  def search_charities(arg)
    charity_fields = [:name, :category]
    charity_fields.each do |field|
      if Charity.find_by(field => arg) || Charity.find_by(field => arg.capitalize) || Charity.find_by(field => arg.upcase) || Charity.find_by(field => arg.downcase)
        @results.push Charity.find_by(field => arg) || @results.push(Charity.find_by(field => arg.capitalize)) || @results.push(Charity.find_by(field => arg.upcase)) || @results.push(Charity.find_by(field => arg.downcase))
      end
    end
  end

  def search_goals(arg)
    goal_fields = [:title, :description]
    goal_fields.each do |field|
      if Goal.find_by(field => arg) || Goal.find_by(field => arg.capitalize) || Goal.find_by(field => arg.upcase) || Goal.find_by(field => arg.downcase)
        @results.push Goal.find_by(field => arg) || @results.push(Goal.find_by(field => arg.capitalize)) || @results.push(Goal.find_by(field => arg.upcase)) || @results.push(Goal.find_by(field => arg.downcase))
      end
    end
  end

  def search_milestones(arg)
    if Milestone.find_by(description: arg) || Milestone.find_by(description: arg.capitalize) || Milestone.find_by(description: arg.upcase) || Milestone.find_by(description: arg.downcase)
      @results.push Milestone.find_by(description: arg) || @results.push(Milestone.find_by(description: arg.capitalize)) || @results.push(Milestone.find_by(description: arg.upcase)) || @results.push(Milestone.find_by(description: arg.downcase))
    end
  end

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
        @secondary_search.push(milestone)
      end
    end
  end

  def goal_include_search(word)
    Goal.all.each do |goal|
      if goal.title.include?(word) || goal.title.include?(word.capitalize)
        @secondary_search.push(goal)
      elsif goal.description.include?(word)
        @secondary_search.push(goal)
      end
    end
  end

  def charity_include_search(word)
    Charity.all.each do |charity|
      if charity.name.include?(word.upcase)
        @secondary_search.push(charity)
      elsif charity.category.include?(word) || charity.category.include?(word.capitalize)
        @secondary_search.push (charity)
      end
    end
  end

  def user_include_search(word)
    User.all.each do |user|
      if user.username.include?(word) || user.username.include?(word.capitalize)
        @secondary_search.push(user)
      elsif user.email.include?(word)
        @secondary_search.push(user)
      end
    end
  end
end