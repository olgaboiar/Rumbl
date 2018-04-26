require "sinatra"
require "sinatra/activerecord"
require_relative './models/user'
require_relative './models/post'
require_relative './models/tag'
require_relative './models/postTag'

set :database, {adapter: 'postgresql', database: 'icelandblog'}
enable :sessions

get '/' do
    erb :index
end

get '/signup' do
    erb :'/signup'
end

post '/user/new' do 
    @newuser = User.create(first_name: params[:first_name], last_name: params[:last_name],screen_name: params[:screen_name], email: params[:email], userpic: params[:userpic], birthday: params[:birthday], password: params[:password])
    #Setting the session with key of ID to be equal to the users id
    #Essentialy this "Logs them in"
    session[:id] = @newuser.id
    redirect '/profile'
end

get '/profile' do
    @user = User.find(session[:id])
    erb :profile
end