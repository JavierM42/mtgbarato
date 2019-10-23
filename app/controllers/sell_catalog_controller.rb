class SellCatalogController < ApplicationController
  def index
    if current_user
      @matches = ListingMatcherService.new(current_user.sell_listings).match(BuyListing)
    end

    @buy_listings = BuyListing.all

    render
  end
end
