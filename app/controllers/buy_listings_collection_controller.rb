class BuyListingsCollectionController < ApplicationController
  before_action :authenticate_user!

  def update
    @sell_listings = SellListing.all

    @buy_listings_text = params[:buy_listings_text]
    begin
      new_buy_listings = TextToListingService.new(params[:buy_listings_text], BuyListing).parse
      current_user.buy_listings.destroy_all
      current_user.buy_listings = new_buy_listings
      current_user.save
      flash[:alert] = nil
      flash[:notice] = 'Tu lista de compra fue actualizada. Podés ver la publicación en la pestaña Cartas buscadas'
    rescue CardNotFoundError => e
      flash[:alert] = e.message
    end
    
    @buy_listings = current_user.buy_listings
    @matches = ListingMatcherService.new(current_user.buy_listings).match(SellListing)
    render 'buy_listings/index'
  end
end
