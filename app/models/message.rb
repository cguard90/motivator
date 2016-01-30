class Message < ActiveRecord::Base
  belongs_to :goal
  belongs_to :user

  validates :content, presence: true
  # delegate :setter, to: :goal, prefix: true
  delegate :setter_username, to: :goal, prefix: true
  delegate :title, to: :goal, prefix: true
  delegate :username, to: :user

  def self.broadcast
    Message.includes(:user, goal: :setter).order(created_at: :desc).limit(20)
  end

end
