require 'rubygems'

require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require 'rspotify'

# RSpotify.authenticate(ENV['SPOTIFY_ID'], ENV['SPOTIFY_SECRET'])

require_relative 'lib/guest'

class App < Sinatra::Base
  enable :sessions
  set :session_secret, 'TESTING'

  enable :static

  register Sinatra::Flash

  configure do
    set :app_file, __FILE__
  end

  configure :development do
    register Sinatra::Reloader
    enable :logging, :dump_errors, :raise_errors
  end

  configure :production do
    disable :raise_errors, :show_exceptions
  end
end

%w(helpers models routes).each do |dir|
  require_relative File.join(dir, 'init')
end