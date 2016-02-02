class Goal < ActiveRecord::Base
  belongs_to :setter, class_name: "User"
  belongs_to :tender, class_name: "User"
  belongs_to :charity
  has_many :milestones
  has_many :messages
  has_many :pledges

  validates :title, presence: true
  validates :description, presence: true
  validates :tender, presence: true
  validates :setter_pledge, presence: true

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

  def supporter_pledge_total
    pledges = self.pledges.where.not(user: self.setter)
    pledges.count > 0 ? pledges.map { |pledge| pledge.amount }.reduce(:+) : 0
  end

  def left_to_match
    self.setter_pledge - self.supporter_pledge_total
  end

  def is_fully_funded?
    setter_pledge = self.setter_pledge ? self.setter_pledge : 0
    setter_pledge <= self.supporter_pledge_total
  end

  def is_active?
    final_milestone = self.milestones.order(:deadline).last
    final_milestone.deadline > Date.today && final_milestone.confirmed == false
  end

  def is_resolved?
    self.is_complete? || self.is_failed?
  end

  def is_complete?
    self.milestones.where(confirmed: false).count <= 0
  end

  def is_failed?
    self.milestones.where("deadline < ? AND confirmed = ?", Date.today, false).count > 0
  end

  def self.sort_time
    includes(:tender).order(created_at: :desc)
  end

  def self.sort_charity
    includes(:tender).order(charity_id: :asc)
  end

  def self.sort_setter
    joins(:setter).order('users.username')

  end

end
