class AddTimestamps < ActiveRecord::Migration[5.0]
  def change
    add_column :sell_listings, :created_at, :datetime, null: false, default: DateTime.now
    add_column :sell_listings, :updated_at, :datetime, null: false, default: DateTime.now
    add_column :buy_listings, :created_at, :datetime, null: false, default: DateTime.now
    add_column :buy_listings, :updated_at, :datetime, null: false, default: DateTime.now
  end
end
