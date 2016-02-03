class Message < ActiveRecord::Base
  belongs_to :goal
  belongs_to :user

  validates :content, presence: true
  delegate :setter_username, to: :goal, prefix: true
  delegate :title, to: :goal, prefix: true
  delegate :username, to: :user

  private

end
