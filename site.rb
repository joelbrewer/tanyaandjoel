require 'sinatra'
require 'sinatra/activerecord'

set :database, 'sqlite3:blog.db'

class Post < ActiveRecord::Base
end

helpers do
  def random_photo_from(directory)
    dir = File.dirname(__FILE__) + directory
    num_photos = Dir.entries(dir).size - 2
    random = Random.new.rand(1..num_photos)
    "%img(src='home/home#{random}.jpg')"
  end
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
    haml :post, :locals => {:post => @post }
  else
    haml :error
  end
end

get '/style.css' do
  scss :style
end
