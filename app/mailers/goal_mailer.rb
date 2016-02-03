class GoalMailer < ApplicationMailer

  def invite_tender_email(goal)
    @goal = goal
    @setter = @goal.setter
    @tender = @goal.tender
    @goal_url = "http://localhost:3000/goals/#{@goal.id}"
    @register_url = "http://localhost:3000/register"

    mail to: @tender.email, subject: "#{@setter.username} has asked for your help"
  end

end