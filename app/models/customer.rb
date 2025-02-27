class Customer < ApplicationRecord
  has_many :contracts
  has_many :subscriptions, through: :contracts
end
