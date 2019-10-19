class AddFoilToBuyAndSellListings < ActiveRecord::Migration[5.0]
  def change
    add_column :sell_listings, :foil, :boolean, default: false
    add_column :buy_listings, :foil, :boolean, default: false
  end
end
