class Contract < ApplicationRecord
  belongs_to :customer
  has_many :subscriptions
  enum :status,  active: 0, inactive: 1, expired: 2, canceled: 3 
end
