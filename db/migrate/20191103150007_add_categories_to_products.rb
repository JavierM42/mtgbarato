class AddCategoriesToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :category, :string, default: "Otros"
  end
end
