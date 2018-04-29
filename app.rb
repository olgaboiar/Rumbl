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

get '/login' do
    erb :'/login'
end

post '/user/login' do 
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user != nil
        session[:id] = @user.id
        erb :profile
    else
        redirect '/signup'
    end 
end

post '/user/new' do 
    @newuser = User.create(
        first_name: params[:first_name],
        last_name: params[:last_name],
        screen_name: params[:screen_name],
        email: params[:email],
        userpic: params[:userpic],
        birthday: params[:birthday],
        password: params[:password])
    session[:id] = @newuser.id
    redirect '/profile'
end

get '/profile' do
    @user = User.find(session[:id])
    erb :profile
end

get '/profile/edit' do 
    @user = User.find(session[:id])
    erb :editprofile
end

put '/profile/edit' do
    @user = User.find(session[:id])
    @user.update(
        first_name: params[:first_name],
        last_name: params[:last_name],
        screen_name: params[:screen_name],
        email: params[:email],
        userpic: params[:userpic],
        birthday: params[:birthday],
        password: params[:password])
    redirect '/profile'
end

get '/profile/delete' do 
    erb :deleteprofile
end

delete '/profile/delete' do
    @user = User.find(session[:id])
    @user.destroy
    redirect '/posts'
end

get '/post/new' do
    erb :new_post
end

post '/post/save' do 
    @author = session[:id]
    @newpost = Post.create(title: params[:title], subtitle: params[:subtitle], picture: params[:picture], postbody: params[:postbody], user_id: @author, time_created: Time.now)
    redirect '/posts'
end

get '/myposts' do
    @user = User.find(session[:id])
    @posts = @user.posts
    erb :postgrid
end

get '/posts' do 
    @posts = Post.all
    erb :postgrid
end

get '/posts/:username' do
    @user = User.find_by_screen_name(params[:username])
    @posts = @user.posts
    erb :postgrid
end

get '/post/:id' do
    @post = Post.find(params[:id])
    erb :post
end