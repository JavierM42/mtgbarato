class ScryfallSearchService
  def initialize(name:, set_name: nil)
    @name = name
    @set_name = set_name
  end

  def search
    response = HTTParty.get("https://api.scryfall.com/cards/search?q=#{URI.encode(query)}")
    if response.code == 200
      json_response = JSON.parse(response.body)
      if json_response["data"] && card_data = json_response["data"][0]
        {
          name: card_data['name'],
          price: card_data['prices']['usd'],
          foil_price: card_data['prices']['usd_foil'],
          set_name: card_data['set_name'],
          thumbnail_uri: card_data['image_uris'] ? card_data['image_uris']['small'] : card_data['card_faces'][0]['image_uris']['small'],
          image_uri: card_data['image_uris'] ? card_data['image_uris']['png'] : card_data['card_faces'][0]['image_uris']['png'],
          standard_legal: card_data['legalities']['standard'] == 'legal',
          modern_legal: card_data['legalities']['modern'] == 'legal'
        }
      end
    end
  end

  def query
    query = @name
    if @set_name
      query += " set:\"#{@set_name.gsub(':', '')}'\""
    end
    query
  end
end