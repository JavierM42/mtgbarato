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
      if with_amount = line.match(/^(?<amount>[0-9]+)x (?<rest>.*)/)
        amount = with_amount[:amount]
        unparsed = with_amount[:rest]
      end
      if with_notes = line.match(/^(?<name>.*) \((?<notes>.*)\)/)
        notes = with_notes[:notes]
        unparsed = with_notes[:name]
      end
      {
        amount: amount.to_i,
        card: unparsed,
        link: get_link(unparsed),
        notes: notes
      }
    end
  end

  def get_link(card_name)
    "https://deckbox.org/mtg/#{URI.escape(card_name)}"
  end
end