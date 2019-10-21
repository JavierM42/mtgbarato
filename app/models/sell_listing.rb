class SellListing < ApplicationRecord
  belongs_to :card
  belongs_to :user

  def specific_set
    false
  end

  def any_set
    false
  end

  def set_not_confirmed
    !set_confirmed
  end
end
