class Milestone < ActiveRecord::Base
  belongs_to :goal

  validates :description, presence: true
  validates :deadline, presence: true
end