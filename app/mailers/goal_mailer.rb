class GoalMailer < ApplicationMailer

  def invite_tender_email(goal)
    @goal = goal
    @setter = @goal.setter
    @tender = @goal.tender
    @goal_url = "https://protected-refuge-11475.herokuapp.com/goals/#{@goal.id}"
    @register_url = "https://protected-refuge-11475.herokuapp.com/register"

    mail to: @tender.email, subject: "#{@setter.username} has asked for your help"
  end

end