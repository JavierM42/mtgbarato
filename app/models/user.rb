class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates_uniqueness_of :user_name, if: -> { user_name.present? }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sell_listings
  has_many :buy_listings
  has_many :products

  def full_name
    "#{first_name} #{last_name}"
  end
end
