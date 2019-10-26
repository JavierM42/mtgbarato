namespace :scheduled do
  desc "updates all card prices"
  task :update_prices => :environment do
    Card.all.each do |card|
      scryfall_data = ScryfallSearchService.new(name: card.name, set_name: card.set_name).search
      if scryfall_data
        card.price = scryfall_data[:price]
        card.foil_price = scryfall_data[:foil_price]
        card.standard_legal = scryfall_data[:standard_legal]
        card.modern_legal = scryfall_data[:modern_legal]
        card.save
        card.sell_listings.each do |listing|
          listing.update_price
          listing.save
        end
        card.buy_listings.each do |listing|
          listing.update_price
          listing.save
        end
      end
    end
  end
end