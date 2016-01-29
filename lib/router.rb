require 'sinatra/base'

class FyberServer < Sinatra::Base

  def self.run!
    super
  end

  get '/' do
    return "Hello World"
  end



end
