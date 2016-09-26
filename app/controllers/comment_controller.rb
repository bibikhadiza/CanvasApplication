class CommentController < ApplicationController

  post "/comments/:id/new" do
    @user = current_user
    @image = Image.find(params[:id])
    @comment = Comment.create(content: params[:comment])
    @comment.user = @user
    @image.comments << @comment

    erb :"/images/show"
  end












end
