ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'

require 'router.rb'

class IntegrationTest < MiniTest::Test

  include Rack::Test::Methods

  def app
    FyberServer    
  end

  def test_index
    get '/'
    assert last_response.ok?
    assert last_response.body.include? '<input type="text" name="uid" id="uid">'
    assert last_response.body.include? '<input type="text" name="pub0" id="pub0">'
    assert last_response.body.include? '<input type="number" name="page" id="page">'
  end

  def test_offers_correct_request
    post '/offers/', { pub0: "test", page: 1, uid: "player" }
    assert last_response.ok?
    assert last_response.body.include? '<table>'
    assert last_response.body.include? '<th>Title</th>'
    assert last_response.body.include? '<th>Payout</th>'
    assert last_response.body.include? '<th>Thumbnail</th>'
    assert last_response.body.include? '<img'
  end
end
