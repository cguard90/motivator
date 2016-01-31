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
