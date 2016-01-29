require 'sinatra/base'

class FyberServer < Sinatra::Base
  set :views, 'views'

  def self.run!
    super
  end

  get '/' do
    erb :form
  end



end
