class AddPriceToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :buy_listings, :price, :float
    add_column :sell_listings, :price, :float
  end
end
