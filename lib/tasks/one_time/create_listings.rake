namespace :one_time do
  desc "creates listings for old users"
  task :create_listings => :environment do
    User.all.each do |user|
      new_sell_listings = ListingGeneratorService.new(user.sell, SellListing).generate_listings
      user.sell_listings.destroy_all
      user.sell_listings = new_sell_listings
      new_buy_listings = ListingGeneratorService.new(user.buy, BuyListing).generate_listings
      user.buy_listings.destroy_all
      user.buy_listings = new_buy_listings
      user.save
    end
  end
end