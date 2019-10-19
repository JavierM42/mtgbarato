class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sell_listings

  def buy_catalog
    CatalogService.new(self, buy).create_catalog
  end

  def sell_catalog
    sell_listings.map do |listing|
      {
        user: self,
        card_name: listing.card.name,
        amount: listing.amount,
        deckbox_link: "https://deckbox.org/mtg/#{URI.escape(listing.card.name)}",
        tcg_link: "https://shop.tcgplayer.com/magic/product/show?newSearch=false&IsProductNameExact=false&ProductName=#{listing.card.name.gsub(" ", "+")}&orientation=list",
        price: listing.card.price,
        set_name: listing.card.set_name,
        notes: listing.notes
      }
    end
  end
end
