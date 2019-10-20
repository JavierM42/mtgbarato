class ListingMatcherService
  def initialize(user_listings)
    @user_listings = user_listings
  end

  def match(listing_type)
    listing_type.all.select do |listing|
      @user_listings.map { |user_listing| user_listing.card.name }.include? listing.card.name
    end
  end
end