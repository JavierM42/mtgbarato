class RemoveBuyAndSellFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :buy, :string
    remove_column :users, :sell, :string
  end
end
