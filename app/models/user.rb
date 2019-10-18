class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def buy_catalog
    CatalogService.new(self, buy).create_catalog
  end

  def sell_catalog
    CatalogService.new(self, sell).create_catalog
  end
end
