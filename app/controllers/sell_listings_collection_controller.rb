class SellListingsCollectionController < ApplicationController
  before_action :authenticate_user!

  def index
    @sell_listings_text = ListingToTextService.new(current_user.sell_listings).parse
    
    render
  end

  def create
    @sell_listings_text = params[:sell_listings_text]
    begin
      new_sell_listings = TextToListingService.new(params[:sell_listings_text], SellListing).parse
      current_user.sell_listings << new_sell_listings
      flash[:alert] = nil
      flash[:notice] = 'Se agregaron items a tu lista de venta.'
    rescue CardNotFoundError => e
      flash[:alert] = e.message
    end

    @sell_listings = current_user.sell_listings
    render 'sell_listings/index'
  end

  def update
    @sell_listings_text = params[:sell_listings_text]
    begin
      new_sell_listings = TextToListingService.new(params[:sell_listings_text], SellListing).parse
      current_user.sell_listings.destroy_all
      current_user.sell_listings = new_sell_listings
      current_user.save
      flash[:alert] = nil
      flash[:notice] = 'Tu lista de venta fue actualizada.'
    rescue CardNotFoundError => e
      flash[:alert] = e.message
    end

    @sell_listings = current_user.sell_listings
    render 'sell_listings/index'
  end
end
