class SellController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    redirect_to sell_edit_path and return if current_user

    @sought_cards = User.all.map { |user| user.buy_catalog }.flatten

    render
  end

  def edit
    @sought_cards = User.all.map { |user| user.buy_catalog }.flatten
    @sell = current_user.sell

    render
  end

  def update
    @sought_cards = User.all.map { |user| user.buy_catalog }.flatten

    @sell = params[:sell]
    begin
      new_sell_listings = ListingGeneratorService.new(params[:sell]).generate_listings
      current_user.sell_listings.destroy_all
      current_user.sell_listings = new_sell_listings
      current_user.sell = @sell
      current_user.save
      flash[:alert] = nil
      flash[:notice] = 'Tu lista de venta fue actualizada. Podés ver todas las publicaciones en la pestaña Comprar'
    rescue CardNotFoundError => e
      flash[:alert] = e.message
    end

    render :edit
  end
end
