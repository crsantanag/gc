class Deposit < ApplicationRecord
  belongs_to :user
  belongs_to :apartment
end
