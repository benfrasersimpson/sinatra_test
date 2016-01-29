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

  def test_that_it_rejects_nonstandard_params
    assert_raises(ArgumentError) {
      @request[:nonstandard_param] = "foo"
    }
  end

  def test_request_accepts_pub_optional_params
    @request[:pub0] = "foo"
    @request[:pub4233] = "bar"
  end

  def test_hash_key_correctly_calculated
    Request.api_key = "e95a21621a1865bcbae3bee89c4d4f84"
    
    assert_equal("7a2b1604c03d46eec1ecd4a686787b75dd693c4d", @request.send(:calculate_hash_key, "appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186&ip=212.45.111.17&locale=de&page=2&ps_time=1312211903&pub0=campaign2&timestamp=1312553361&uid=player1"))
  end

  def test_param_string_created_correctly
    expected_param_string =
    "appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186&ip=212.45.111.17&locale=de&page=2&ps_time=1312211903&pub0=campaign2&timestamp=1312553361&uid=player1&hashkey=7a2b1604c03d46eec1ecd4a686787b75dd693c4d"

    @request[:appid] = 157
    @request[:uid] = "player1"
    @request[:ip] = "212.45.111.17"
    @request[:locale] = "de"
    @request[:device_id] = "2b6f0cc904d137be2e1730235f5664094b831186"
    @request[:ps_time] = 1312211903
    @request[:pub0] = "campaign2"
    @request[:page] = 2
    @request[:timestamp] = 1312553361

    Request.api_key = "e95a21621a1865bcbae3bee89c4d4f84"

    assert_equal(expected_param_string, @request.send(:param_string))
  end

  def test_param_string_raises_exception_when_missing_required_params
    assert_raises(ArgumentError) {
      @request.send(:param_string)
    }
  end

  def test_request_url_created_correctly
    expected_url = "http://api.fyber.com/feed/v1/offers.json?appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186&ip=212.45.111.17&locale=de&page=2&ps_time=1312211903&pub0=campaign2&timestamp=1312553361&uid=player1&hashkey=7a2b1604c03d46eec1ecd4a686787b75dd693c4d"

    @request[:appid] = 157
    @request[:uid] = "player1"
    @request[:ip] = "212.45.111.17"
    @request[:locale] = "de"
    @request[:device_id] = "2b6f0cc904d137be2e1730235f5664094b831186"
    @request[:ps_time] = 1312211903
    @request[:pub0] = "campaign2"
    @request[:page] = 2
    @request[:timestamp] = 1312553361

    Request.api_key = "e95a21621a1865bcbae3bee89c4d4f84"

    assert_equal(expected_url, @request.request_url)
  end
end
