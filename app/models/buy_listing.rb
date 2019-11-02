class BuyListing < ApplicationRecord
  belongs_to :card
  belongs_to :user

  def initialize(attributes = {})
    super(attributes)
    self.price = calculate_price
  end

  def set_confirmed
    false
  end

  def set_not_confirmed
    false
  end

  def any_set
    !specific_set
  end

  def calculate_price
    base_price = (foil ? card.foil_price : card.price) || 0
    base_price * (100 - discount) / 100
  end
end
