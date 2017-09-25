class PokemonController < ApplicationController

  def index
    render json: { "message": "ok!" }
  end

  def show
    # ***---POKEMON API---***
    # find the pokemon with the same id
    id = params[:id]

    # envoking key saved locally
    pokemon_response = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{id}")

    parsed_pokemon_response = JSON.parse(pokemon_response.body)

    # ***---GIPHY API---***
    api_key = ENV["GIPHY_KEY"]
# byebug
    giphy_reponse = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{api_key}&q=#{parsed_pokemon_response['name']}&rating=g")

    parsed_giphy_response = JSON.parse(giphy_reponse.body)

    # ***---RENDER---***
    render json: {
      "id": parsed_pokemon_response['id'],
      "name": parsed_pokemon_response['name'],
      "weight": parsed_pokemon_response['weight'],
      "types": extract_pokemon_types(parsed_pokemon_response),
      "stats": extract_pokemon_stats(parsed_pokemon_response),
      "gif": parsed_giphy_response['data'][0]['url']
     }
  end

  private

  def extract_pokemon_types(parsed_pokemon_response)
    pokemon_type = []
    parsed_pokemon_response['types'].each do |slot|
      pokemon_type << slot['type']['name']
    end
    pokemon_type
  end

  def extract_pokemon_stats(parsed_pokemon_response)
    pokemon_stats = []
    parsed_pokemon_response['stats'].each do |slot|
      pokemon_stats << {"name" => slot['stat']['name'], "effort" => slot['effort'], "base_stat" => slot['base_stat']}
    end
    pokemon_stats
  end

  # def extract_giphy_url
  #   parsed_giphy_response['data'][0]['url']

end
