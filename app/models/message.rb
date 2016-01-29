class Message < ActiveRecord::Base
  belongs_to :goal
  belongs_to :user

  validates :content, presence: true
end
