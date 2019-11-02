class AddDiscountToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :buy_listings, :discount, :integer, default: 0
    add_column :sell_listings, :discount, :integer, default: 0
  end
end
