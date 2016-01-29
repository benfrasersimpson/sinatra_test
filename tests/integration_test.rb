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

end
