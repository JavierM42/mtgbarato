class BuyController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    redirect_to buy_edit_path and return if current_user

    @sell_listings = SellListing.all

    render
  end

  def edit
    @sell_listings = SellListing.all
    @buy_listings_text = ListingToTextService.new(current_user.buy_listings).parse
    @matches = ListingMatcherService.new(current_user.buy_listings).match(SellListing)
    
    render
  end

  def update
    @sell_listings = SellListing.all

    @buy_listings_text = params[:buy_listings_text]
    begin
      new_buy_listings = TextToListingService.new(params[:buy_listings_text], BuyListing).parse
      current_user.buy_listings.destroy_all
      current_user.buy_listings = new_buy_listings
      current_user.buy = @buy_listings_text
      current_user.save
      flash[:alert] = nil
      flash[:notice] = 'Tu lista de compra fue actualizada. Podés ver la publicación en la pestaña Vender'
    rescue CardNotFoundError => e
      flash[:alert] = e.message
    end
    
    @matches = ListingMatcherService.new(current_user.buy_listings).match(SellListing)
    render :edit
  end
end
