class BuyController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    redirect_to buy_edit_path and return if current_user

    @sell_listings = SellListing.all

    render
  end

  def edit
    @sell_listings = SellListing.all
    @buy = current_user.buy
    
    render
  end

  def update
    @sell_listings = SellListing.all
    
    @buy = params[:buy]
    begin
      new_buy_listings = ListingGeneratorService.new(params[:buy], BuyListing).generate_listings
      current_user.buy_listings.destroy_all
      current_user.buy_listings = new_buy_listings
      current_user.buy = @buy
      current_user.save
      flash[:alert] = nil
      flash[:notice] = 'Tu lista de compra fue actualizada. Podés ver la publicación en la pestaña Vender'
    rescue CardNotFoundError => e
      flash[:alert] = e.message
    end
    
    render :edit
  end
end