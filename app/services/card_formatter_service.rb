require 'uri'

class CardFormatterService
  def initialize(text)
    @text = text
  end

  def format
    @text.split(/\n/).map do |line|
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
      {
        amount: amount.to_i,
        card: unparsed,
        deckbox_link: deckbox_link(unparsed),
        tcg_link: tcg_link(unparsed),
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