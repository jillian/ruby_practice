require 'sinatra'
require 'yaml/store'

get '/' do
	@title = 'Sinatra polling app!'
	erb :index
end

post '/vote' do
	@title = 'Thanks for voting!'
	@vote  = params['vote']
	@store = YAML::Store.new 'votes.yml'
	@store.transaction do
	  @store['votes'] ||= {}
	  @store['votes'][@vote] ||= 0
	  @store['votes'][@vote] += 1
	end
	erb :vote
end

get '/results' do 
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction { @store['votes'] }
  erb :results
end

Choices = {
  'HAM' => 'Hamburger',
  'PIZ' => 'Pizza',
  'CUR' => 'Curry',
  'NOO' => 'Noodles',
}