class StripeController < ApplicationController
  protect_from_forgery :except => :webhook

  def webhook
    binding.pry
  end
# Stripe.api_key = SECRET_KEY
# require "json"

# post 'my/webhook/url' do
#   event_json = JSON.parse(request.body.read)
end