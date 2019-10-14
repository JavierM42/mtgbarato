class AddSellToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :sell, :text
  end
end
