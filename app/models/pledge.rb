class Pledge < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal

  validates  :amount, presence: true, length: { minimum:1 }

  def announcement(current_user)
    Message.create(
      user_id: 1,
      goal_id: self.goal_id,
      content: "#{current_user.username} has pledged $#{self.amount} in support of #{self.goal.setter.username}'s goal to '#{self.goal.title}'."
    )
  end

end
