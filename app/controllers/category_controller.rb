class CategoryController < ApplicationController


  get "/categories/:id" do
    @user = User.find(session[:id])
    @category = Category.find_by(name: params[:id])
    erb :"categories/index"
  end






end
