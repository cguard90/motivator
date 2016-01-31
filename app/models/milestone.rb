class Milestone < ActiveRecord::Base
  belongs_to :goal

  validates :description, presence: true
  validates :deadline, presence: true

  def announcement(current_user)
    binding.pry
    Message.create(
      user_id: 1,
      goal_id: self.goal_id,
      content: "#{current_user.username} has confirmed that #{self.goal.setter.username} has completed the milestone '#{self.description}'."
    )
    binding.pry
  end


end