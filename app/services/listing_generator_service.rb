class ListingGeneratorService
  def initialize(raw_text)
    @raw_text = raw_text
  end

  def generate_listings
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
      name = unparsed

      if card = CardService.new(name).find_or_create_card
        SellListing.new(card: card, amount: amount, notes: notes, set_confirmed: false)
      else
        raise CardNotFoundError.new("#{name} no parece ser una carta válida")
      end
    end
  end
end