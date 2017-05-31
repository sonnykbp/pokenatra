require 'sinatra'
require 'sinatra/reloader'
require 'active_record'

# Load the file to connect to the DB
require_relative 'db/connection'

# Load models
require_relative 'models/pokemon'


get '/' do
  erb :index
end

delete '/pokemon/:id' do
  @pokemon = Pokemon.delete(params[:id])
  redirect "/"
end

post '/pokemon/new' do
  @newpokemon = Pokemon.create(params[:pokemon])
  redirect "/pokemon/#{@newpokemon.id}"
end

get '/pokemon/new' do
  erb :"pokemon/new"
end

get '/pokemon' do
  @pokemons = Pokemon.all.order(id: :asc)
  erb :"pokemon/pokemons"
end

get '/pokemon/:id' do
  @pokemon = Pokemon.find(params[:id])
  erb :"pokemon/show"
end

get "/pokemon/:id/edit" do
  @pokemon = Pokemon.find(params[:id])
  erb(:"pokemon/edit")
end

put '/pokemon/:id' do
  @pokemon = Pokemon.find(params[:id])
  @pokemon.update(params[:pokemon])
  redirect("/pokemon/#{@pokemon.id}")
end
