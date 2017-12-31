require 'omniauth'
require 'omniauth-spotify'

class App < Sinatra::Base
  use OmniAuth::Builder do
    provider :developer
    provider :guest
    provider :spotify, ENV['SPOTIFY_ID'], ENV['SPOTIFY_SECRET'],
      scope: 'playlist-modify-public playlist-read-collaborative'
  end

  post '/auth/:guest/callback' do
    request.env['omniauth.auth']['info']['name']
  end

  post '/auth/:provider/callback' do
    begin
      user = User.create_from_hash(request.env['omniauth.auth'])
      session[:user_id] = user.id
      redirect '/'
    rescue
      redirect '/auth/failure'
    end
  end

  get '/auth/failure' do
    erb "It looks like you didn't login..."
  end
end