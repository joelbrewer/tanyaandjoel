require File.expand_path '../test_helper.rb', __FILE__

class Post < ActiveRecord::Base
end

class TanyaAndJoelTest < MiniTest::Test

  include Rack::Test::Methods

  def app
    TanyaAndJoel
  end

  def test_it_shows_latest_post_title
    lucille_viii = Post.new(:title => "Lucille VIII", :body => "meow.").save

    get '/', @latest_post => lucille_viii
    assert last_response.ok?
    puts last_response.body.include?("Lucille VIII")
  end
end
                                       

