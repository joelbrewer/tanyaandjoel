require 'sinatra'
require 'sinatra/activerecord'

set :database, 'sqlite3:blog.db'

class Post < ActiveRecord::Base
end

get '/' do
  haml :home
end

get '/blog' do
  haml :blog
end
