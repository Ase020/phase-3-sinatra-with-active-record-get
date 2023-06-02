class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  get '/' do
    { message: "Hello world" }.to_json
  end

  get '/games' do
    game = Game.all.order(:id).limit(10)
     game.to_json
  end

  get "/games/:id" do
    id = params[:id]
    game = Game.find(id)
    game.to_json(only: [:id, :title, :genre, :price], include: {reviews: { only: [:id, :comment, :score], include: { user: { only: [:id, :name] } } } })
  end

end
