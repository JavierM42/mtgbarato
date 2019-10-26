class Card < ApplicationRecord
  has_many :sell_listings
  has_many :buy_listings
end
