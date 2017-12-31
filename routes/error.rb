class App < Sinatra::Base
  not_found do
    erb :'error/404'
  end

  error 403 do
    erb :'error/403'
  end
end