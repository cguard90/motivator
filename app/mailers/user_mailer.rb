class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url = 'https://protected-refuge-11475.herokuapp.com/login'

    mail to: @user.email, subject: 'Welcome to Motivator!'
  end

end