


class Image < ActiveRecord::Base
belongs_to :user
belongs_to :like
belongs_to :dislike
has_many :comments
has_many :image_categories
has_many :categories, through: :image_categories



















end
