require 'minitest/autorun'
require 'request'

class TestRequest < Minitest::Test
  def setup
    @request = Request.new
  end
  
  def test_that_it_accepts_params
    @request[:uid] = "player1"
    assert_equal("player1", @request[:uid])
  end

  def test_hash_key_correctly_calculated
    Request.api_key = "e95a21621a1865bcbae3bee89c4d4f84"
    
    assert_equal("7a2b1604c03d46eec1ecd4a686787b75dd693c4d", @request.send(:calculate_hash_key, "appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186&ip=212.45.111.17&locale=de&page=2&ps_time=1312211903&pub0=campaign2&timestamp=1312553361&uid=player1"))
  end

end
