class SellCatalogController < ApplicationController
  def index
    respond_to do |format|
      format.html do
        if current_user
          @matches = ListingMatcherService.new(current_user.buy_listings).match(SellListing)
        end

        @featured_listings = SellListing.where.not(discount: 0).where('price > 15').order("RANDOM()").limit(5)
        render
      end

      format.json do
        render json: SellListingDatatable.new(params)
      end
    end
  end
end
