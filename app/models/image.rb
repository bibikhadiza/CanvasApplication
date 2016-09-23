


class Image < ActiveRecord::Base
belongs_to :user
has_many :comments
has_many :image_categories
has_many :categories, through: :image_categories
has_many :likes
has_many :dislikes



















end
