class BuyListing < ApplicationRecord
  belongs_to :card
  belongs_to :user

  def set_confirmed
    false
  end

  def set_not_confirmed
    false
  end

  def any_set
    !specific_set
  end

  def price
    foil ? card.foil_price : card.price
  end
end
