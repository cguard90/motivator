class Goal < ActiveRecord::Base
  belongs_to :setter, class_name: "User"
  belongs_to :tender, class_name: "User"
  belongs_to :charity
  has_many :milestones
  has_many :messages
  has_many :pledges

  validates :title, presence: true
  validates :description, presence: true
  #just a comment
end
