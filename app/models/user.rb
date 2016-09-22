class User < ActiveRecord::Base
  has_secure_password
  belongs_to :like
  belongs_to :dislike
  has_many :images
  has_many :comments
  has_many :image_categories
  has_many :categories, through: :images



















end
