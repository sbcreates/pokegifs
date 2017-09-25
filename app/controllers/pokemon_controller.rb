class PokemonController < ApplicationController

  def index
    render json: { "message": "ok!" }
  end

  def show
    # find the pokemon with the same id
    id = params[:id]
    # envoking key saved locally
    api_key = ENV["GIHPY_KEY"]
    response = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{id}")
    parsed_response = JSON.parse(response.body)

    render json: { "message": "ok!" }
  end

end
