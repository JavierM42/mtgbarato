class ListingToTextService
  def initialize(listings)
    @listings = listings || []
  end

  def parse
    @listings
      .sort_by { |listing| listing.card.name }
      .map do |listing|
        amount = "#{listing.amount}x "
        name = "#{listing.card.name} "
        set = listing.set_confirmed || listing.specific_set ? "(#{listing.card.set_name}) " : ''
        foil = listing.foil ? "*F* " : ''
        notes = listing.notes.present? ? "_#{listing.notes}_" : ''
        amount + name + set + foil + notes
      end
      .join("\n")
  end
end