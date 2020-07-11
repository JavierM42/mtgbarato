class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def home
    @sell_listings_count = SellListing.count
    @buy_listings_count = BuyListing.count
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :user_name, :phone, :buy, :sell])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :user_name, :phone, :buy, :sell])
  end
end
