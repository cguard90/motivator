class Pledge < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal

  validates  :amount, presence: true, length: { minimum:1 }
end
