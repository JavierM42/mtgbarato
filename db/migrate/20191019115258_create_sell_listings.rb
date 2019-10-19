class CreateSellListings < ActiveRecord::Migration[5.0]
  def change
    create_table :sell_listings do |t|
      t.references :card, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :amount
      t.string :notes
      t.boolean :set_confirmed, default: false
    end
  end
end
