class AddImageAndThumbnailToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :image_uri, :string
    add_column :cards, :thumbnail_uri, :string
  end
end
