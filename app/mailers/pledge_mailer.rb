class PledgeMailer < ApplicationMailer

  def setter_notification_email(pledge)
    @pledge = pledge
    @goal = @pledge.goal
    @setter = @goal.setter
    @goal_url = "http://localhost:3000/goals/#{@goal.id}"

    mail to: @setter.email, subject: "#{@pledge.user.username} supported your goal!"
  end

end