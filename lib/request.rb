require 'digest'

class Request

  @@required_params = [
                        :appid,
                        :uid,
                        :locale,
                        :timestamp
                      ]

  @@allowed_params = [
                       :appid,
                       :uid,
                       :locale,
                       :os_version,
                       :timestamp,
                       :hashkey,
                       :apple_idfa,
                       :apple_idfa_tracking_enabled,
                       :ip,
                       :page,
                       :offer_types,
                       :ps_time,
                       :device,
                       :device_id,
                     ]

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
    raise(ArgumentError, "Unknown parameter #{key}") unless @@allowed_params.include?(key) || key =~ /pub\d+/
    @request_params[key] = value
  end

  def request_url(format = "json")
    raise(ArgumentError, "unknown format #{format}") unless %w[json xml].include? format
    "http://api.fyber.com/feed/v1/offers.#{format}?#{param_string}"
  end

  def param_string
    @request_params[:timestamp] ||= Time.now.to_i 

    if missing_required_params.any?
      raise(ArgumentError, "Missing params #{missing_required_params.join(',')}")
    end

    @request_params = @request_params.sort.to_h
    request_string = @request_params.map {|k,v| "#{k}=#{v}"}.join('&')
    hash_key = calculate_hash_key(request_string)

    request_string + "&hashkey=#{hash_key}"
  end

  def calculate_hash_key(request_string)
    request_string += "&#{@@api_key}"
    Digest::SHA1.hexdigest(request_string)
  end

  def missing_required_params
    (@@required_params - @request_params.keys)
  end
end
