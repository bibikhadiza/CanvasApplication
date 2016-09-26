require 'rack-flash'



class UserController < ApplicationController

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  post '/users/signup' do
    valid_email = params[:email]
    if valid_email.match(VALID_EMAIL_REGEX) != nil
      @user = User.create(name: params[:name], email: params[:email], password: params[:password])
      session[:id] = @user.id
      redirect "/users/home"
    else
      redirect "/signup"
    end
  end


  post '/users/login' do
    valid_email = params[:email]
    if valid_email.match(VALID_EMAIL_REGEX) != nil
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        session[:id] = @user.id
        redirect "/users/home"
    else
      redirect "/"
    end
    end
  end


  get '/users/home' do
    if logged_in?
      @user = User.find(session[:id])
      erb :'/users/home'
    else
      redirect "/"
    end
  end

  get "/users/:id/homepage" do
    @user = User.find(params[:id])
    erb :'users/index'
  end


  get "/users/logout" do
    session.clear
    redirect '/'
  end















end
