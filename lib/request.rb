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

  def param_string(timestamp = Time.now.to_i)
    @request_params[:timestamp] = timestamp

    @request_params = @request_params.sort.to_h
    request_string = @request_params.map {|k,v| "#{k}=#{v}"}.join('&')
    hash_key = calculate_hash_key(request_string)

    request_string + "&hashkey=#{hash_key}"
  end

  def calculate_hash_key(request_string)
    request_string += "&#{@@api_key}"
    Digest::SHA1.hexdigest(request_string)
  end
end
