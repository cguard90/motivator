# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def charity_data(action, state_name, keyword)
  token = ENV['GIVE_API_TOKEN']
  url = "https://app.place2give.com/Service.svc/give-api?token=#{token}&format=json&action=#{action}&PageNumber=1&NumPerPage=100&ProvState=#{state_name}&Keyword=#{keyword}"
  response = HTTParty.get(url)
  return response.parsed_response
end

hash = JSON.parse(charity_data("searchCharities", "NY", "animals"))
charities = hash['give-api']['data']['charities']['charity']

charities.each do |charity|
  Charity.create!(name:charity['Name'],category:charity['Type'])
end

User.create(username: "something", email: "test@email.com", password: '1234')

Charity.create(name: "test Charity", category: "test category for charity")

Goal.create(setter_id: User.first.id, tender_id: User.first.id, charity_id: Charity.first.id, title: "test Goal", description: "goal description")
5`
Milestone.create(goal_id: Goal.first.id, description: "Test Milestone", deadline: Date.today)

Pledge.create(user_id: User.first.id, goal_id: Goal.first.id, amount: 20)
