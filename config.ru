require 'sinatra'

set :views, File.dirname(__FILE__) + "/views"
set :env,  :production
disable :run

require './app.rb'

run Sinatra::Application
