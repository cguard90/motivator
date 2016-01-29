class User < ActiveRecord::Base
  has_secure_password
  has_many :set_goals, class_name: "Goal"
  has_many :tended_goals, class_name: "Goal"
  has_many :pledges
  has_many :messages

  validates :name, presence: true, length: {in: 8..20}
  validates :email, presence: true

  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create


end