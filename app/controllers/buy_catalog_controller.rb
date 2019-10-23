class BuyCatalogController < ApplicationController
  def index
    if current_user
      @matches = ListingMatcherService.new(current_user.buy_listings).match(SellListing)
    end

    @sell_listings = SellListing.all
    render
  end
end
