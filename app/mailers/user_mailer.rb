class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url = user.email

    mail to: @user.email, subject: 'Welcome to Motivator!'
  end

end