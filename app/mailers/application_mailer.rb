class ApplicationMailer < ActionMailer::Base
  default from: "notifications@motivator.com"
  layout 'mailer'
end