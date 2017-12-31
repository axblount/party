class App < Sinatra::Base
  before do
    begin
      @user = User[session[:user_id]]
    rescue
      @user = nil
    end
  end

  helpers do
    def authenticate!
      if @user.nil?
        flash[:warn] = "Please login first!"
        redirect '/login'
      end
    end
  end
end