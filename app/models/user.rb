class User < ActiveRecord::Base
  has_secure_password
  has_many :images
  has_many :comments
  has_many :image_categories
  has_many :categories, through: :images
  has_many :likes
  has_many :dislikes

  def liked_images
    self.likes.map do |like|
      like.image
    end
  end

  def disliked_images
    self.dislikes.map do |dislike|
      dislike.image
    end
  end




















end
