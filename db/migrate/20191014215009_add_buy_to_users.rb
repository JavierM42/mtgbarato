class AddBuyToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :buy, :text
  end
end
