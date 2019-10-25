class BuyListingsCollectionController < ApplicationController
  before_action :authenticate_user!

  def index
    @buy_listings_text = ListingToTextService.new(current_user.buy_listings).parse
    
    render
  end

  def create
    @buy_listings_text = params[:buy_listings_text]
    begin
      new_buy_listings = TextToListingService.new(params[:buy_listings_text], BuyListing).parse
      current_user.buy_listings << new_buy_listings
      flash[:alert] = nil
      flash[:notice] = 'Se agregaron items a tu lista de compra.'
    rescue CardNotFoundError => e
      flash[:alert] = e.message
    end

    @buy_listings = current_user.buy_listings
    render 'buy_listings/index'
  end

  def update
    @buy_listings_text = params[:buy_listings_text]
    begin
      new_buy_listings = TextToListingService.new(params[:buy_listings_text], BuyListing).parse
      current_user.buy_listings.destroy_all
      current_user.buy_listings = new_buy_listings
      current_user.save
      flash[:alert] = nil
      flash[:notice] = 'Tu lista de compra fue actualizada.'
    rescue CardNotFoundError => e
      flash[:alert] = e.message
    end
    
    @buy_listings = current_user.buy_listings
    render 'buy_listings/index'
  end
end
