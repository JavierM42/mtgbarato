class TextToListingService
  def initialize(raw_text, class_name)
    @raw_text = raw_text
    @class_name = class_name
  end

  def parse
    @raw_text.split(/\n/).map do |line|
      unparsed = line
      amount = 1
      foil = false
      set_name = nil
      notes = nil
      if with_notes = unparsed.match(/(?<rest>.*) _(?<notes>.*)_/)
        notes = with_notes[:notes]
        unparsed = with_notes[:rest]
      end
      if with_foil = unparsed.match(/(?<rest>.*) \*F\*/)
        foil = true
        unparsed = with_foil[:rest]
      end
      if with_set_name = unparsed.match(/(?<rest>.*) \((?<set_name>.*)\)/)
        set_name = with_set_name[:set_name]
        unparsed = with_set_name[:rest]
      end
      if with_amount = unparsed.match(/(?<amount>[0-9]+)x (?<rest>.*)/)
        amount = with_amount[:amount]
        unparsed = with_amount[:rest]
      end
      name = unparsed

      if card = CardService.new(name: name, set_name: set_name).find_or_create_card
        if @class_name.name == SellListing.name
          SellListing.new(card: card, amount: amount, notes: notes, set_confirmed: set_name != nil, foil: foil)
        else
          BuyListing.new(card: card, amount: amount, notes: notes, specific_set: set_name != nil, foil: foil)
        end
      else
        raise CardNotFoundError.new("#{name} no parece ser una carta válida")
      end
    end
  end
end