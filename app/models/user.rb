class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum :role,
        [ :normal,
          :admin ]

  has_many :apartments
  has_many :deposits
  has_many :bills
end
