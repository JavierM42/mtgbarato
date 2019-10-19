require 'uri'

class CatalogService
  def initialize(user, raw_text)
    @raw_text = raw_text || ""
    @user = user
  end

  def create_catalog
    @raw_text.split(/\n/).map do |line|
      unparsed = line
      amount = 1
      notes = nil
      if with_notes = line.match(/(?<rest>.*) \((?<notes>.*)\)/)
        notes = with_notes[:notes]
        unparsed = with_notes[:rest]
      end
      if with_amount = unparsed.match(/(?<amount>[0-9]+)x (?<rest>.*)/)
        amount = with_amount[:amount]
        unparsed = with_amount[:rest]
      end
      scryfall_data = ScryfallSearchService.new(unparsed).search
      {
        user: @user,
        card_name: unparsed.titleize,
        amount: amount.to_i,
        deckbox_link: deckbox_link(unparsed),
        tcg_link: tcg_link(unparsed),
        price: scryfall_data[:price],
        set_name: scryfall_data[:set_name],
        notes: notes
      }
    end
  end

  def deckbox_link(card_name)
    "https://deckbox.org/mtg/#{URI.escape(card_name)}"
  end

  def tcg_link(card_name)
    "https://shop.tcgplayer.com/magic/product/show?newSearch=false&IsProductNameExact=false&ProductName=#{card_name.gsub(" ", "+")}&orientation=list"
  end
end