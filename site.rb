require 'haml'
require 'sinatra'
require 'sinatra/activerecord'

set :database, 'sqlite3:blog.db'

class TanyaAndJoel < Sinatra::Base

  class Post < ActiveRecord::Base
  end

  helpers do
    def random_photo_from(directory)
      dir = File.dirname(__FILE__) + directory
      num_photos = Dir.entries(dir).size - 2
      random = Random.new.rand(1..num_photos)
      "%img(src='home/home#{random}.jpg')"
    end

    def protected!
      return if authorized?
      headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
      halt 401, "Not authorized\n"
    end

    def authorized?
      @auth ||= Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['admin', 'admin']
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

  get '/protected' do
    protected!
    "Well hello there you sly dog."
  end

  get '/style.css' do
    scss :style
  end

end
