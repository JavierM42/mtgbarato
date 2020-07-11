class UsersController < ApplicationController
  def show
    respond_to do |format|
      format.html do
        @user = User.find_by(user_name: params[:id]) || User.find_by(id: params[:id])
        render
      end

      format.json do
        params[:user_id] = params[:id]
        if params[:sell]
          render json: SellListingDatatable.new(params)
        else
          render json: BuyListingDatatable.new(params)
        end
      end
    end
  end
end
