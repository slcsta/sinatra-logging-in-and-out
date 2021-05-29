require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    # find user in database based on "username"
    @user = User.find_by(username: params[:username])

    # if there is a match, set the session to the user's ID
    if @user && @user.password == params[:password]
      session[:user_id] = @user.id
    # and redirect to /account route
      redirect to '/account'
    else
      erb :error
    end
  end

  get '/account' do
    #on the account page set up a link called 'Log Out' that clears the session
    erb :account
  end

  get '/logout' do
    # clear session to logout
    session.clear
    #redirect to home
    redirect to '/'
  end
end

