require "sinatra"
require "sinatra/activerecord"
require_relative './models/user'
require_relative './models/post'
require_relative './models/tag'
require_relative './models/postTag'

set :database, {adapter: 'postgresql', database: 'icelandblog'}
enable :sessions