class BuyCatalogController < ApplicationController
  def index
    respond_to do |format|
      format.html do
        if current_user
          @matches = ListingMatcherService.new(current_user.sell_listings).match(BuyListing)
        end
    
        @buy_listings = BuyListing.all
    
        render
      end
      
      format.json do
        render json: BuyListingDatatable.new(params)
      end
    end
  end
end
