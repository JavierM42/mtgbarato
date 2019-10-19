namespace :scheduled do
  desc "updates all card prices"
  task :update_prices => :environment do
    Card.all.each do |card|
      scryfall_data = ScryfallSearchService.new(name: card.name, set_name: card.set_name).search
      if scryfall_data
        card.price = scryfall_data[:price]
        card.save
      end
    end
  end
end