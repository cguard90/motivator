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

(1..5).to_a.each do |number|
  user = User.create(user_name: "User#{number}", email: Faker::Internet.safe_email, password: "password")
  goal = Survey.create(setter: user, tender: user, charity: Charity.all.sample, title: Faker::Hacker.say_something_smart, user: user)
    (1..3).to_a.each do |milestones_number|
      milestone = Milestone.create(goal: goal, description: Faker::Name.title , deadline: Faker::Time.forward(50, :evening))
      pledge = Pledge.create(user:user, goal: goal, amount: Faker::Number.between(1, 100))
    end
end
