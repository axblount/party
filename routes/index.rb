class App < Sinatra::Base
  get '/' do
    if @user
      erb :index
    else
      erb :login
    end
  end

  get '/logout' do
    session[:user_id] = nil
    redirect '/login'
  end
end