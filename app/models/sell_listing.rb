class SellListing < ApplicationRecord
  belongs_to :card
  belongs_to :user

  def initialize(attributes = {})
    super(attributes)
    self.price = calculate_price
  end

  def specific_set
    false
  end

  def any_set
    false
  end

  def set_not_confirmed
    !set_confirmed
  end

  def calculate_price
    base_price = (foil ? card.foil_price : card.price) || 0
    base_price * (100 - discount) / 100
  end
end
