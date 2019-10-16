require 'uri'

class CardFormatterService
  def initialize(text)
    @text = text
  end

  def format
    @text.split(/\n/).map do |line|
      with_notes = line.match(/^(?<amount>[0-9]+)x (?<name>.*) \((?<notes>.*)\)$/)
      with_amount = line.match(/^(?<amount>[0-9]+)x (?<name>.*)$/)
      if with_notes
        {
          amount: with_notes[:amount].to_i,
          card: with_notes[:name],
          link: get_link(with_notes[:name]),
          notes: with_notes[:notes]
        }
      elsif with_amount
        {
          amount: with_amount[:amount].to_i,
          card: with_amount[:name],
          link: get_link(with_amount[:name]),
          comments: nil
        }
      else
        {
          amount: 1,
          card: line,
          link: get_link(line),
          comments: nil
        }
      end
    end
  end

  def get_link(card_name)
    "https://deckbox.org/mtg/#{URI.escape(card_name)}"
  end
end