class CardService
  def initialize(name)
    @name = name
  end

  def find_or_create_card
    scryfall_data = ScryfallSearchService.new(@name).search
    if scryfall_data
      Card.where(name: scryfall_data[:name]).first || Card.create(name: scryfall_data[:name], price: scryfall_data[:price], set_name: scryfall_data[:set_name])
    end
  end
end