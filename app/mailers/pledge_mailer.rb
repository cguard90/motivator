class PledgeMailer < ApplicationMailer

  def setter_notification_email(pledge)
    @pledge = pledge
    @goal = @pledge.goal
    @setter = @goal.setter
    @goal_url = "https://protected-refuge-11475.herokuapp.com/goals/#{@goal.id}"

    mail to: @setter.email, subject: "#{@pledge.user.username} supported your goal!"
  end

end