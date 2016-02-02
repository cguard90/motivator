class Pledge < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal

  validates  :amount, presence: true, length: { minimum:1 }

  def announce
    self.goal.messages.create(
      user: User.system_user,
      goal: self.goal,
      content: "#{self.user.username} has pledged $#{self.amount} in support of #{self.goal.setter.username}'s goal to '#{self.goal.title}'."
    )
  end

end
