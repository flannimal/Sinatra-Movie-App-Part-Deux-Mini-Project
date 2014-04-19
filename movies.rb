require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'typhoeus'
require 'json'
require 'pry'

# A setup step to get rspec tests running.
configure do
  root = File.expand_path(File.dirname(__FILE__))
  set :views, File.join(root,'views')
end

get '/' do 
	erb :index      
end

get '/results' do
	res=Typhoeus.get("www.omdbapi.com/", :params => { :s => params["movie"] }) 
  json_results = JSON.parse(res.body) 
  @movies = json_results["Search"]   # .each this on erb page
  erb :results
end

get '/movie/:imdbID' do
	res=Typhoeus.get("www.omdbapi.com/", :params => { :i => params["imdbID"] })
	@pic = JSON.parse(res.body) 
	erb :poster
end

