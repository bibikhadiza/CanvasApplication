require 'rack-flash'


class ImageController < ApplicationController

  post '/image/new' do
    logged_in?
    @user = User.find(session[:id])
    if params[:category_name]
      @image = Image.new(filepath: params[:image][:filename])
      @image.user_id = @user.id
      @image.save
      @user.images << @image
      @like = Like.new
      @dislike = Dislike.new
      @like.images << @image
      @dislike.images << @image
      @like.save
      @dislike.save
      File.open("./public/image/#{@image.filepath}", 'w') do |f|
        f.write(params[:image][:tempfile].read)
      end
      @category = Category.find(params[:category_name])
      @category.each do |cat|
        cat.images << @image
        cat.save
      end
    else
      flash[:message] = "****Please Select Art Category****"
    end
    redirect "/users/home"
  end


  get "/image/:id/display" do
    @image = Image.find(params[:id])
    @user = User.find(session[:id])
    erb :"images/display"
  end



  post "/image/:id/comment" do
    @user = User.find(session[:id])
    @image = Image.find(params[:id])
    @comment = Comment.create(content: params[:comment])
    @image.comments << @comment
    erb :"/images/display"
  end


  get "/image/:id" do
    @user = User.find(session[:id])
    @category = Category.find_by(name: params[:id])
    erb :"/category/new"
  end



  get "/image/:id/like" do
    @image = Image.find_by_id(params[:id])
    @user = User.find_by_id(session[:id])
  #   Dislike.all.each do |dislike|
  #     if dislike.images.include?(@image) && dislike.users.include?(@user)
  #       dislike.users.delete(@user)
  #       dislike.save
  #       redirect "/image/#{@image.id}/display"
  #     end
  #   end
  #
  #   Like.all.each do |like|
  #     if like.images.include?(@image) && like.users.include?(@user)
  #       like.users.delete(@user)
  #       like.save
  #       like.users << @user
  #       like.save
  #       redirect "/image/#{@image.id}/display"
  #     end
  #   end
  #   redirect "/image/#{@image.id}/display"
  # end

    Like.all.each do |like|
      if like.images.include?(@image)
        @like = like
      end
    end

    Dislike.all.each do |dislike|
      if dislike.images.include?(@image)
        @dislike = dislike
      end
    end

    if @dislike.users.include?(@user)
      @dislike.users.delete(@user)
    end
    if !@like.users.include?(@user)
      @like.users << @user
    end
    redirect "/image/#{@image.id}/display"
  end





  get "/image/:id/dislike" do
    @image = Image.find_by_id(params[:id])
    @user = User.find_by_id(session[:id])
    Dislike.all.each do |dislike|
      if dislike.images.include?(@image)
        @dislike = dislike
        !@dislike.users.include?(@user)
        @dislike.users << @user
      end
    end
    Like.all.each do |like|
      if like.images.include?(@image)
        @like = like
      end
    end


    if @like.users.include?(@user)
      @like.users.delete(@user)
    end
    if !@dislike.users.include?(@user)
      @dislike.users << @user
    end
  redirect "/image/#{@image.id}/display"
  end


  get '/image/:id/delete' do
    @image = Image.find(params[:id])
    @image.destroy
    redirect '/users/home'
  end


end
