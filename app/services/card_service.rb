class CardService
  def initialize(name:, set_name: nil)
    @name = name
    @set_name = set_name
  end

  def find_or_create_card
    if scryfall_data
      existing_card || Card.create(name: scryfall_data[:name], price: scryfall_data[:price], set_name: scryfall_data[:set_name])
    end
  end

  def existing_card
    if @set_name
      Card.where(name: scryfall_data[:name], set_name: scryfall_data[:set_name]).first
    else
      Card.where(name: scryfall_data[:name]).first
    end
  end

  def scryfall_data
    @scryfall_data ||= ScryfallSearchService.new(name: @name, set_name: @set_name).search
  end
end