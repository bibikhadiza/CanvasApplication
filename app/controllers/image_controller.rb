require 'rack-flash'


class ImageController < ApplicationController

  post '/images/new' do
    logged_in?
    @user = current_user
    if params[:category_name] && params[:image]
      @image = Image.new(filepath: params[:image][:filename])
      @image.user_id = @user.id
      @image.save
      @user.images << @image
      File.open("./public/image/#{@image.filepath}", 'w') do |f|
        f.write(params[:image][:tempfile].read)
      end
      category = Category.find(params[:category_name])
      category.each do |cat|
        cat.images << @image
        cat.save
      end
    else
      if !params[:category_name] && !params[:image]
        flash[:message] = "**Please select an image and a category**"
      elsif !params[:category_name]
        flash[:message] = "****Please Select Art Category****"
      else
      flash[:message] = "***Please select an Image***"
      end
    end
    redirect "/users/home"
  end


  get "/images/:id" do
    @image = Image.find(params[:id])
    @user = current_user
    erb :"images/show"
  end


  # get "/categories/:id" do
  #   @user = User.find(session[:id])
  #   @category = Category.find_by(name: params[:id])
  #   erb :"/category/new"
  # end


  get "/images/:id/like" do
    @image = Image.find_by_id(params[:id])
    @user = current_user

    if @user.disliked_images.include?(@image)
      Dislike.find_by(user: @user, image: @image).destroy
      @user.save
    end


    if !@user.liked_images.include?(@image)
      like = Like.create(image_id: @image.id, user_id: @user.id)
      @user.likes << like
      @user.save
      redirect "/images/#{@image.id}"
    else
      redirect "/images/#{@image.id}"
    end
  end



  get "/images/:id/dislike" do
    @image = Image.find_by_id(params[:id])
    @user = current_user

    if @user.liked_images.include?(@image)
      Like.find_by(user: @user, image: @image).destroy
      @user.save
    end


    if !@user.disliked_images.include?(@image)
      dislike = Dislike.create(image_id: @image.id, user_id: @user.id)
      @user.dislikes << dislike
      @user.save
      redirect "/images/#{@image.id}"
    else
      redirect "/images/#{@image.id}"
    end
  end


  delete '/images/:id/delete' do
    @image = Image.find(params[:id])
    @image.delete
    redirect '/users/home'
  end


end
