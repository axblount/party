class App < Sinatra::Base
  before '/party/?*' do
    authenticate!
  end

  post '/party/start' do
    party = @user.start_party(params[:name], params[:playlist_id])
    redirect "/party/#{party.id}"
  end

  get '/party/:id' do
    @party = Party[params[:id]] || halt(404)
    halt(403) unless @party.guests.first(id: @user.id)
    @host = @party.host
    @now_playing = RSpotify::User.find(@party.host.id).currently_playing

    erb :party
  end
end