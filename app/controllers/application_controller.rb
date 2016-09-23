require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash
    register Sinatra::ActiveRecordExtension

    enable :sessions                                        #in sinatra, the public folder is to hold all the styling
    set :session_secret, "my_application_secret"            #by default sinatra will look for a public folder
    set :views, Proc.new { File.join(root, "../views/") }   #if you set your public folder to public in the app
                                                           #controller then you will have a public fodler in your applciation. else you create a public folder in the css
  get '/' do                                                #folder and now when you read your filepath in the erb
                                                       #sinatra will by default call on the public folder.
    erb :index                                              #rememeber!
  end

  get '/signup' do
    erb :'/users/signup'
  end


  get '/login' do
    erb :'/users/login'
  end

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      @user ||= User.find(session[:id]) #if the user if false not in session
      # if @user                        #find the user in the database and set the
      #   @user                         #user to the session else just return the
      # else                             #user. this way I am not going back to
      #   @user = User.find(session[:id])   #the database and looking for the user
      # end                               #whih lingers the app process.
    end
  end





end
