class MilestoneMailer < ApplicationMailer

  def announce_milestone_email(milestone)
    @milestone = milestone
    @goal = milestone.goal
    @goal_url = "https://protected-refuge-11475.herokuapp.com/goals/#{@goal.id}"
    @setter = milestone.goal.setter
    @tender = milestone.goal.tender


    if @milestone.completed
      mail to: @tender.email, subject: "#{@setter.username} completed a milestone"
    else
      mail to: @setter.email, subject: "#{@tender.username} confirmed your milestone"
    end
  end

end