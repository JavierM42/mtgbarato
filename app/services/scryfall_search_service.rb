class ScryfallSearchService
  def initialize(name:, set_name: nil)
    @name = name
    @set_name = set_name
  end

  def search
    response = HTTParty.get("https://api.scryfall.com/cards/search?q=#{query}sort=usd")
    if response.code == 200
      json_response = JSON.parse(response.body)
      if json_response["data"] && card_data = json_response["data"][0]
        {
          name: card_data['name'],
          price: card_data['prices']['usd'],
          set_name: card_data['set_name']
        }
      end
    end
  end

  def query
    query = @name
    if @set_name
      query += " set:'#{@set_name}'"
    end
    query
  end
end