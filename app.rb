require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

require_relative 'cookbook'
require_relative 'recipe'
filepath = 'recipes.csv'

get '/cookbook' do
  cookbook = Cookbook.new(filepath)
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

post '/addrecipe' do
  cookbook = Cookbook.new(filepath)
  @recipes = cookbook.all
  recipe = Recipe.new(params['name'], params['description'],
                      params['preptime'], params['difficulty'])
  cookbook.add_recipe(recipe)
  cookbook.save
  redirect '/cookbook'
end

post '/destroyrecipe' do
  cookbook = Cookbook.new(filepath)
  @recipes = cookbook.all
  @recipes = cookbook.remove_recipe(params['index'].to_i - 1)
  erb :index
  redirect '/cookbook'
end
