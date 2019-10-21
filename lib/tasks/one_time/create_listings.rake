namespace :one_time do
  desc "creates listings for old users"
  task :create_listings => :environment do
    User.all.each do |user|
      puts user.sell
      new_sell_listings = TextToListingService.new(user.sell || "", SellListing).parse
      user.sell_listings.destroy_all
      user.sell_listings = new_sell_listings
      puts user.buy
      new_buy_listings = TextToListingService.new(user.buy || "", BuyListing).parse
      user.buy_listings.destroy_all
      user.buy_listings = new_buy_listings
      user.save
    end
  end
end