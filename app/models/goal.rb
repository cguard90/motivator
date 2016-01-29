class Goal < ActiveRecord::Base
  has_one :setter, class_name: "User"
  has_one :tender, class_name: "User"
  has_one :charity

  validates :title, presence: true
  validates :description, presence: true
end