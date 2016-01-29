require 'sinatra/base'
require "net/http"
require "uri"
require 'json'
require 'yaml'

class FyberServer < Sinatra::Base
  set :views, 'views'

  def self.run!
    @config = YAML.load_file('config/secret.yml')
    Request.api_key = @config["api_key"]
    super
  end

  def handle_success(json)
    if json['code'] == 'OK'
      @offers = json['offers'].map do |offer|
        offer.select! do |k, v|
          %w[title payout thumbnail].include? k
        end
      end
  
      erb :offers
    else
      return "Error: #{json['message']}" || "Fyber replied with an error"
    end
  end

  get '/' do
    erb :form
  end

  post '/offers/' do
    request = Request.new
  
    request[:appid] = 157
    request[:ip] = "109.235.143.113"
    request[:locale] = "de"
    request[:device_id] = "2b6f0cc904d137be2e1730235f5664094b83"
    request[:offer_types] = 112
  
    request[:pub0] = params[:pub0]
    request[:page] = params[:page]
    request[:uid] = params[:uid]

    uri = URI.parse(request.request_url)
    response = Net::HTTP.get_response(uri)

    json = JSON.parse(response.body)
    handle_success(json)
  end

end
