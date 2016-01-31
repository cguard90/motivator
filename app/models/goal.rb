class Goal < ActiveRecord::Base
  belongs_to :setter, class_name: "User"
  belongs_to :tender, class_name: "User"
  belongs_to :charity
  has_many :milestones
  has_many :messages
  has_many :pledges

  validates :title, presence: true
  validates :description, presence: true

  delegate :username, to: :setter, prefix: true

  def announcement
    Message.create(
      user_id: 1,
      goal_id: self.id,
      content: "#{self.setter.username} has set a goal to '#{self.title}'."
    )
  end

  def total_pledges_by(user)
    pledges = self.pledges.where(user_id: user.id)
    pledges.map { |pledge| pledge.amount }.reduce(:+)
  end

  def is_fully_funded?
    pledges = self.pledges.where.not(user: self.setter)
    limit = self.limit ? self.limit : 0
    limit <= pledges.map { |pledge| pledge.amount }.reduce(:+)
  end

  def self.sort_time
    order(created_at: :desc)
  end

  def self.sort_charity
    order(charity_id: :asc)
  end

  def self.sort_tender
    order(tender_id: :asc)
  end

end
