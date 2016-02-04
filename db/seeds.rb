require 'date'

def charity_data(action, state_name, keyword)
  token = ENV['GIVE_API_TOKEN']
  url = "https://app.place2give.com/Service.svc/give-api?token=#{token}&format=json&action=#{action}&PageNumber=1&NumPerPage=100&ProvState=#{state_name}&Keyword=#{keyword}"
  response = HTTParty.get(url)
  return response.parsed_response
end

api_data = charity_data("searchCharities", "NY", "animals")
hash = JSON.parse(api_data)
charities_hash = hash['give-api']['data']['charities']['charity']
charities = []

charities_hash.map do |f|
  if f["ContactInfo"]["URL"] != nil && f["Type"] != nil
    charities.push(f)
  end
end

charities.each do |charity|
  Charity.create!(name:charity['Name'],category:charity['Type'],url:charity["ContactInfo"]["URL"])
end

admin = User.create!(
  username: "Motivator",
  email: "motivator@dbc.com",
  password: "sam1zack2steven3chris3"
  )

al = User.create!(
  username: "Al Albert",
  email: "al@example.com",
  password: "password"
  )

bob = User.create!(
  username: "Bob Bobson",
  email: "bob@example.com",
  password: "password"
  )

cathy = User.create!(
  username: "Cathy Cathbert",
  email: "cathy@example.com",
  password: "password"
  )

dana = User.create!(
  username: "Dana Dansen",
  email: "dana@example.com",
  password: "password"
  )

edna = User.create!(
  username: "Edna Edgerton",
  email: "edna@example.com",
  password: "password"
  )

# Begin Al's goal

goal_al = Goal.create!(
  setter: al,
  tender: bob,
  charity: Charity.all.sample,
  title: "Stop smoking",
  description: "I'm smoking 2 packs a day. I want to cut down by half a pack a week, so in a month, I'm through with cigarettes!",
  setter_pledge: 100,
  accepted: true
  )

milestone_1_al = Milestone.create!(
  goal: goal_al,
  description: "A pack and a half a day.",
  deadline: Date.today+7,
  value:25
  )

milestone_2_al = Milestone.create!(
  goal: goal_al,
  description: "A pack a day.",
  deadline: Date.today+14,
  value:25
  )

milestone_3_al = Milestone.create!(
  goal: goal_al,
  description: "Half a pack a day.",
  deadline: Date.today+21,
  value:25
  )

milestone_4_al = Milestone.create!(
  goal: goal_al,
  description: "No more smoking!",
  deadline: Date.today+28,
  value:25
  )

pledge_1_al = Pledge.create!(
  user: bob,
  goal: goal_al,
  amount: 50
  )

pledge_2_al = Pledge.create!(
  user: edna,
  goal: goal_al,
  amount: 20
  )

pledge_3_al = Pledge.create!(
  user: dana,
  goal: goal_al,
  amount: 30
  )

message_1_al = Message.create!(
    user: User.real_users.sample,
    goal: goal_al,
    content: Faker::Hipster.sentence
  )

message_2_al = Message.create!(
    user: User.real_users.sample,
    goal: goal_al,
    content: Faker::Hipster.sentence
  )

message_3_al = Message.create!(
    user: User.real_users.sample,
    goal: goal_al,
    content: Faker::Hipster.sentence
  )

# Begin Bob's goal

goal_bob = Goal.create!(
  setter: bob,
  tender: dana,
  charity: Charity.all.sample,
  title: "Lose weight",
  description: "I need to get rid of this beer gut. Help me get back into something other than sweat pants!",
  setter_pledge: 50,
  accepted: true
  )

milestone_1_bob = Milestone.create!(
  goal: goal_bob,
  description: "Lose 5 pounds.",
  deadline: Date.today+10,
  value:33
  )

milestone_2_bob = Milestone.create!(
  goal: goal_bob,
  description: "Lose 10 pounds",
  deadline: Date.today+20,
  value:33
  )

milestone_3_bob = Milestone.create!(
  goal: goal_bob,
  description: "Lose 15 pounds",
  deadline: Date.today+30,
  value:33
  )

pledge_1_bob = Pledge.create!(
  user: al,
  goal: goal_bob,
  amount: 20
  )

pledge_2_bob = Pledge.create!(
  user: edna,
  goal: goal_bob,
  amount: 10
  )

pledge_3_bob = Pledge.create!(
  user: cathy,
  goal: goal_bob,
  amount: 20
  )

message_1_bob = Message.create!(
    user: User.real_users.sample,
    goal: goal_bob,
    content: Faker::Hipster.sentence
  )

message_2_bob = Message.create!(
    user: User.real_users.sample,
    goal: goal_bob,
    content: Faker::Hipster.sentence
  )

message_3_bob = Message.create!(
    user: User.real_users.sample,
    goal: goal_al,
    content: Faker::Hipster.sentence
  )

# Begin Cathy's goal

goal_cathy = Goal.create!(
  setter: cathy,
  tender: al,
  charity: Charity.all.sample,
  title: "Cut down on Facebook",
  description: "I'm checking my status like 20 times a day, and I can't stop replying to everyone who pokes me.",
  setter_pledge: 100,
  accepted: true
  )

milestone_1_cathy = Milestone.create!(
  goal: goal_cathy,
  description: "Limit Facebook checks to 5 per day.",
  deadline: Date.today+14,
  value:33
  )

milestone_2_cathy = Milestone.create!(
  goal: goal_cathy,
  description: "Spend no more than 30 minutes a day on Facebook.",
  deadline: Date.today+14,
  value:33
  )

milestone_3_cathy = Milestone.create!(
  goal: goal_cathy,
  description: "Quit playing Farmville.",
  deadline: Date.today+14,
  value:33
  )

pledge_1_cathy = Pledge.create!(
  user: bob,
  goal: goal_cathy,
  amount: 10
  )

pledge_2_cathy = Pledge.create!(
  user: al,
  goal: goal_cathy,
  amount: 10
  )

pledge_3_cathy = Pledge.create!(
  user: dana,
  goal: goal_cathy,
  amount: 15
  )

message_1_cathy = Message.create!(
    user: User.real_users.sample,
    goal: goal_cathy,
    content: Faker::Hipster.sentence
  )

message_2_cathy = Message.create!(
    user: User.real_users.sample,
    goal: goal_cathy,
    content: Faker::Hipster.sentence
  )

message_3_cathy = Message.create!(
    user: User.real_users.sample,
    goal: goal_cathy,
    content: Faker::Hipster.sentence
  )

# Begin Dana's goal

goal_dana = Goal.create!(
  setter: dana,
  tender: bob,
  charity: Charity.all.sample,
  title: "Eat healthier",
  description: "Everyone says I need to stop eating so much junk. I'm going to try to do better.",
  setter_pledge: 75,
  accepted: true
  )

milestone_1_dana = Milestone.create!(
  goal: goal_dana,
  description: "Cut out French Fries.",
  deadline: Date.today+7,
  value:25
  )

milestone_2_dana = Milestone.create!(
  goal: goal_dana,
  description: "Eat veggies at every meal.",
  deadline: Date.today+14,
  value:25
  )

milestone_3_dana = Milestone.create!(
  goal: goal_dana,
  description: "Eat fish 3 times a week.",
  deadline: Date.today+21,
  value:25
  )

milestone_4_dana = Milestone.create!(
  goal: goal_dana,
  description: "Drink 8 glasses of water a day",
  deadline: Date.today+28,
  value:25
  )

pledge_1_dana = Pledge.create!(
  user: bob,
  goal: goal_dana,
  amount: 30
  )

pledge_2_dana = Pledge.create!(
  user: al,
  goal: goal_dana,
  amount: 20
  )

pledge_3_dana = Pledge.create!(
  user: cathy,
  goal: goal_dana,
  amount: 15
  )

message_1_dana = Message.create!(
    user: User.real_users.sample,
    goal: goal_dana,
    content: Faker::Hipster.sentence
  )

message_2_dana = Message.create!(
    user: User.real_users.sample,
    goal: goal_dana,
    content: Faker::Hipster.sentence
  )

message_3_dana = Message.create!(
    user: User.real_users.sample,
    goal: goal_dana,
    content: Faker::Hipster.sentence
  )

# Begin Edna's goal

goal_edna = Goal.create!(
  setter: edna,
  tender: cathy,
  charity: Charity.all.sample,
  title: "Stop watching junk TV",
  description: "I'm staying up all night watching reruns of crappy reality TV shows, and I keep falling asleep at my desk. I've got to stop it and get some sleep before I lose my job.",
  setter_pledge: 150,
  accepted: true
  )

milestone_1_edna = Milestone.create!(
  goal: goal_edna,
  description: "Go to bed by 11pm every night.",
  deadline: Date.today+7,
  value:25
  )

milestone_2_edna = Milestone.create!(
  goal: goal_edna,
  description: "Stop watching 'Kate Plus 8'.",
  deadline: Date.today+14,
  value:25
  )

milestone_3_edna = Milestone.create!(
  goal: goal_edna,
  description: "Stop watching 'Breaking Amish'.",
  deadline: Date.today+21,
  value:25
  )

milestone_4_edna = Milestone.create!(
  goal: goal_edna,
  description: "Stop watching 'Pit Bulls and Parolees'",
  deadline: Date.today+28,
  value:25
  )

pledge_1_edna = Pledge.create!(
  user: al,
  goal: goal_edna,
  amount: 50
  )

pledge_2_edna = Pledge.create!(
  user: cathy,
  goal: goal_edna,
  amount: 20
  )

pledge_3_edna = Pledge.create!(
  user: dana,
  goal: goal_edna,
  amount: 30
  )

message_1_edna = Message.create!(
    user: User.real_users.sample,
    goal: goal_edna,
    content: Faker::Hipster.sentence
  )

message_2_edna = Message.create!(
    user: User.real_users.sample,
    goal: goal_edna,
    content: Faker::Hipster.sentence
  )

message_3_edna = Message.create!(
    user: User.real_users.sample,
    goal: goal_edna,
    content: Faker::Hipster.sentence
  )
