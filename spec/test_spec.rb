require File.expand_path '../test_helper.rb', __FILE__
require 'minitest/pride'

class Post < ActiveRecord::Base
end

class TanyaAndJoelTest < MiniTest::Test

  include Rack::Test::Methods

  def app
    TanyaAndJoel
  end

  def test_homepage_shows_latest_post
    lucille_viii = Post.new(:title => "Lucille VIII", :body => "meow.").save

    get '/', @latest_post => Post.last
    assert last_response.ok?
    puts last_response.body.include?("Lucille VIII")
  end

  def test_existant_blog_title_links_to_blog_page
    lucille_viii = Post.new(:title => "Lucille", :body => "meow.").save
    get '/blog/Lucille'
    assert last_response.body.include?("meow.")
  end

  def test_non_existant_blog_title_shows_error_page
    get '/blog/lklkj'
    assert last_response.body.include?("Sorry! Can't find that one..")
  end

  def test_blog_index_displays_all_posts
    blog_a = Post.new(:title => "Tolkien", :body => "Lord of the Rings").save
    blog_b = Post.new(:title => "Lewis",   :body => "Mere Christianity").save
    get '/blog'
    assert last_response.body.include?("Lord of the Rings")
    assert last_response.body.include?("Mere Christianity")
  end
end
                                       

