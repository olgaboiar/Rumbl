require "sinatra"
require "sinatra/activerecord"
require_relative './models/User'
require_relative './models/Post'
require_relative './models/Tag'
require_relative './models/PostTag'

# set :database, {adapter: 'postgresql', database: 'icelandblog'}
enable :sessions

def logged_in?
    !session[:id].nil?
end

get '/' do
    erb :index, :layout => :indexlayout
end

post '/user/login' do 
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user != nil
        session[:id] = @user.id
        erb :profile, :layout => :layout
    else
        redirect '/'
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
    erb :profile, :layout => :layout
end

get '/profile/edit' do 
    @user = User.find(session[:id])
    erb :editprofile, :layout => :layout
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
    erb :deleteprofile, :layout => :layout
end

delete '/profile/delete' do
    @user = User.find(session[:id])
    @user.destroy
    redirect '/posts'
end

get '/post/new' do
    erb :new_post, :layout => :layout
end

post '/post/save' do 
    @author = session[:id]
    @newpost = Post.create(title: params[:title], subtitle: params[:subtitle], picture: params[:picture], postbody: params[:postbody], user_id: @author, time_created: Time.now)
    redirect '/myposts'
end

get '/myposts' do
    @user = User.find(session[:id])
    @posts = @user.posts
    erb :postgrid, :layout => :layout
end

get '/posts' do 
    @posts = Post.all
    erb :postgrid, :layout => :layout
end

get '/posts/:username' do
    @user = User.find_by_screen_name(params[:username])
    @posts = @user.posts
    erb :postgrid, :layout => :layout
end

get '/post/:id' do
    @post = Post.find(params[:id])
    @author = User.find(@post.user_id)
    @moreposts = @author.posts.limit(2)
    erb :post, :layout => :layout
end

get '/logout' do
    session.clear
    redirect '/'
end