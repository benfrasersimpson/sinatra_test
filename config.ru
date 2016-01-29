require './lib/router.rb'
require 'yaml'

unless ENV['fyber_api']
  ENV['fyber_api'] = YAML.load_file('./config/secret.yml')['api_key']
end

FyberServer.run!
