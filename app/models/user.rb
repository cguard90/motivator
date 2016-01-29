class User < ActiveRecord::Base
  has_secure_password
  has_many :set_goals, class_name: "Goal", foreign_key: "setter_id"
  has_many :tended_goals, class_name: "Goal", foreign_key: "tender_id"
  has_many :pledges
  has_many :messages

  validates :username, presence: true, length: {in: 8..20}
  validates :email, presence: true

  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create


end