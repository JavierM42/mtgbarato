class BuyController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    redirect_to buy_edit_path and return if current_user

    @available_cards = User.all.map { |user| user.sell_catalog }.flatten

    render
  end

  def edit
    @available_cards = User.all.map { |user| user.sell_catalog }.flatten
    @buy = current_user.buy
    
    render
  end

  def update
    @available_cards = User.all.map { |user| user.sell_catalog }.flatten
    @buy = params[:buy]
    current_user.buy = @buy
    current_user.save
    
    flash[:notice] = 'Tu lista de compra fue actualizada. Podés ver la publicación en la pestaña Vender'
    render :edit
  end
end
