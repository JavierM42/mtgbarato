class ProductsCatalogController < ApplicationController
  def index
    @products = Product.all
    render
  end
end
