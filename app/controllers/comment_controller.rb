class CommentController < ApplicationController

  post "/comments/:id/new" do
    @user = current_user
    @image = Image.find(params[:id])
    @comment = Comment.create(content: params[:comment])
    @image.comments << @comment
    erb :"/images/show"
  end












end
