class BuyListingsController < ApplicationController
  before_action :authenticate_user!

  def create
    params[:set_name] = nil unless params[:set_name].present?

    listing = BuyListing.new(
      user: current_user,
      amount: params[:amount],
      notes: params[:notes],
      foil: params[:foil] == 'foil',
      specific_set: params[:set_name].present?
    )

    if card = CardService.new(name: params[:name], set_name: params[:set_name]).find_or_create_card
      listing.card = card
    else
      if params[:set_name]
        flash[:alert] = "Error: #{params[:name]} no existe en el set #{params[:set_name]}"
      else
        flash[:alert] = "Error: #{params[:name]} no parece ser una carta válida"
      end
      redirect_to buy_edit_path and return
    end

    listing.save
    flash[:notice] = "#{listing.card.name} fue agregado a tu lista de compra"
    redirect_to buy_edit_path
  end

  def update
    params[:set_name] = nil unless params[:set_name].present?

    listing = BuyListing.find(params[:id])

    if params[:set_name] != listing.card.set_name
      listing.specific_set = params[:set_name].present?
      if card = CardService.new(name: listing.card.name, set_name: params[:set_name]).find_or_create_card
        listing.card = card
      else
        flash[:alert] = "Error: #{listing.card.name} no existe en el set #{params[:set_name]}"
        redirect_to buy_edit_path and return
      end
    end

    listing.amount = params[:amount]
    listing.notes = params[:notes]
    listing.foil = params[:foil] == 'foil'
    listing.save
    flash[:notice] = "#{listing.card.name} fue actualizado en tu lista de compra"
    redirect_to buy_edit_path
  end

  def destroy
    listing = BuyListing.find(params[:id])
    listing.destroy

    flash[:notice] = "#{listing.card.name} fue eliminado de tu lista de compra"
    redirect_to buy_edit_path
  end
end
