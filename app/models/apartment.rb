class Apartment < ApplicationRecord
  belongs_to :user
  has_many :deposits, dependent: :destroy
end
