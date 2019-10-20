class SellController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    redirect_to sell_edit_path and return if current_user

    @buy_listings = BuyListing.all.shuffle

    render
  end

  def edit
    @buy_listings = BuyListing.all.shuffle
    @sell = current_user.sell
    @matches = ListingMatcherService.new(current_user.sell_listings).match(BuyListing)

    render
  end

  def update
    @buy_listings = BuyListing.all.shuffle

    @sell = params[:sell]
    begin
      new_sell_listings = ListingGeneratorService.new(params[:sell], SellListing).generate_listings
      current_user.sell_listings.destroy_all
      current_user.sell_listings = new_sell_listings
      current_user.sell = @sell
      current_user.save
      flash[:alert] = nil
      flash[:notice] = 'Tu lista de venta fue actualizada. Podés ver todas las publicaciones en la pestaña Comprar'
    rescue CardNotFoundError => e
      flash[:alert] = e.message
    end

    @matches = ListingMatcherService.new(current_user.sell_listings).match(BuyListing)
    render :edit
  end
end
