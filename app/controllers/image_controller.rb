class ImageController < ApplicationController


post '/image/new' do
  @user = User.find(session[:id])
  if params[:image]

    @image = Image.new(filepath: params[:image][:filename])
    @image.user_id = @user.id
    @image.save
    @user.images << @image

    File.open("./public/image/#{@image.filepath}", 'w') do |f|
          f.write(params[:image][:tempfile].read)
    end
  end
  if params[:category_name]
    @category = Category.find(params[:category_name])
    @category.images << @image

  end
  erb :"/users/home"
end


get "/image/:id/display" do
  @image = Image.find(params[:id])
  @user = User.find(session[:id])
  erb :"images/display"
end


post "/image/:id/comment" do
  @image = Image.find(params[:id])
  @comment = Comment.create(content: params[:comment])
  @image.comments << @comment

  erb :"/images/display"
end




get "/image/:id" do
  @category = Category.find_by(name: params[:id])

  erb :"/category/new"
end













end
