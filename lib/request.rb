require 'digest'

class Request

  def initialize
  end

  def self.api_key=(key)
    @@api_key = key
  end

  def calculate_hash_key(request_string)
    request_string += "&#{@@api_key}"
    Digest::SHA1.hexdigest(request_string)
  end
end
