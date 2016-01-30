class User < ActiveRecord::Base
  has_secure_password
  has_many :set_goals, class_name: "Goal", foreign_key: "setter_id"
  has_many :tended_goals, class_name: "Goal", foreign_key: "tender_id"
  has_many :pledges
  has_many :messages

  validates :username, presence: true, length: {in: 8..20}
  validates :email, presence: true

  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  def self.create_or_get_from_oauth(hash)
    existing = User.find_by(provider: hash[:provider], uid: hash[:uid])
    if existing
      return existing
    else
      u = User.new(provider: hash[:provider], uid: hash[:uid])
      u.password = SecureRandom.hex(32)
      u.email = hash[:info][:email]
      u.username = hash[:info][:name]
      u.save
      return u
    end
  end

  def network_messages
    set_goals_msgs = []
    self.set_goals.each do |goal|
      goal.messages.each do |message|
        set_goals_msgs.push message
      end
    end
    tended_goals_msgs = []
    self.tended_goals.each do |goal|
      goal.messages.each do |message|
        tended_goals_msgs.push message
      end
    end
    supported_goals_msgs = []
    self.pledges.each do |pledge|
      pledge.goal.messages.each do |message|
        supported_goals_msgs.push message
      end
    end
    @messages = set_goals_msgs | tended_goals_msgs | supported_goals_msgs
    @messages.sort_by! { |message| message.created_at }
  end

end

