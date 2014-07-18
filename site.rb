require 'sinatra'
require 'sinatra/activerecord'

set :database, 'sqlite3:blog.db'

class Post < ActiveRecord::Base
end

get '/' do
  @latest_post = Post.last
  haml :home
end

get '/blog' do
  @posts = Post.all
  haml :blog
end

get '/blog/:title' do
  @post = Post.find_by title: params[:title].capitalize
  if @post
    haml :post
  else
    haml :error
  end
end

get '/style.css' do
  scss :style
end
