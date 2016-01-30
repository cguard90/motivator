class Message < ActiveRecord::Base
  belongs_to :goal
  belongs_to :user

  validates :content, presence: true

  def self.broadcast
    Message.order(created_at: :desc).limit(20)
  end

end
