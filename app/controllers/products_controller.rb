class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = current_user.products

    render
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    if current_user.products.count < 5
      product = Product.new(
        user: current_user,
        name: params[:name],
        description: params[:description],
        price: params[:price].to_f
      )
      product.save
      flash[:notice] = "#{product.name} fue agregado a tus productos en venta"
      redirect_to products_path
    else
      flash[:alert] = "Error: solo podés tener publicados hasta 5 productos a la vez."
      redirect_to products_path and return
    end
  end

  def update
    product = Product.find(params[:id])
    product.name = params[:name]
    product.description = params[:description]
    product.price = params[:price].to_f
    product.save
    flash[:notice] = "#{product.name} fue actualizado"
    redirect_to products_path
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy

    flash[:notice] = "#{product.name} fue eliminado de tus productos en venta"
    redirect_to products_path
  end
end
