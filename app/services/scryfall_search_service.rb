class ScryfallSearchService
  def initialize(query)
    @query = query
  end

  def search
    response = HTTParty.get("https://api.scryfall.com/cards/named?fuzzy=#{@query.gsub(" ", "+")}")
    if response.code == 200
      json_response = JSON.parse(response.body)
      {
        name: json_response['name'],
        price: json_response['prices']['usd'],
        set_name: json_response['set_name']
      }
    end
  end
end