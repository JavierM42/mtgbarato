class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def formatted_buy
    CardFormatterService.new(buy).format
  end

  def formatted_sell
    CardFormatterService.new(sell).format
  end
end
