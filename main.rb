require 'rubygems'  
require 'sinatra'  
require 'data_mapper'  
require 'json'
require 'dm-serializer'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/app-dev")

class User 
  include DataMapper::Resource  
  property :id, Serial  
  property :name, String, :unique => true, :required => true 
end  
  
DataMapper.finalize.auto_upgrade!  

get '/' do
	User.all.to_a.to_json
end

get '/users' do
	@users = User.all :order => :id.desc
	@title = 'All Users'
	erb :users
end

get '/:name' do
	user = User.new
	user.name = params[:name]
	user.save
	redirect '/'
end

post '/:name' do
	user = User.new
	user.name = params[:name]
	user.save
	redirect '/'
end