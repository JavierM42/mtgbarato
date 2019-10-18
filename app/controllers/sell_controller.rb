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
    current_user.sell = @sell
    current_user.save
    
    flash[:notice] = 'Tu lista de venta fue actualizada. Podés ver la publicación en la pestaña Comprar'
    render :edit
  end
end
