class AddStandardAndModernLegalitiesToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :standard_legal, :boolean, default: false
    add_column :cards, :modern_legal, :boolean, default: false
  end
end
