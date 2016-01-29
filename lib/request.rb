require 'digest'

class Request

  def initialize
    @request_params = Hash.new
  end

  def self.api_key=(key)
    @@api_key = key
  end

  def [](key)
    @request_params[key]
  end

  def []=(key, value)
    @request_params[key] = value
  end

  def calculate_hash_key(request_string)
    request_string += "&#{@@api_key}"
    Digest::SHA1.hexdigest(request_string)
  end
end
