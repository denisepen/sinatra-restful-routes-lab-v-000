require 'pry'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  use Rack::MethodOverride
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end


  post '/recipes' do
    @recipe = Recipe.new(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    @recipe.save
    #  params[:id] = @recipe.id
    @recipes = Recipe.all
    # binding.pry
    redirect "/recipes/#{@recipe.id}"

  end

  get '/recipes/:id' do
    # binding.pry
    # @recipe.id = params[:id]
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.id = params[:id]
    erb :show
  end

use Rack::MethodOverride
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

use Rack::MethodOverride
  patch 'recipes/:id' do
  @recipe = Recipe.find_by_id(params[:id])
  @recipe.title = params[:name]
  @recipe.ingredients = params[:ingredients]
  @recipe.cook_time = params[:cook_time]
  @recipe.save
  redirect "/recipes/#{@recipe.id}"
  end

use Rack::MethodOverride
  delete '/recipes/:id/delete' do #delete action
  @recipe = Recipe.find_by_id(params[:id])
  @recipe.delete
  redirect to '/posts'
end
end
