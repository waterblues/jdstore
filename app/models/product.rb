class Product < ApplicationRecord
  has_many :comments
  belongs_to :category, :optional => true

  mount_uploader :image, ImageUploader

  acts_as_votable
end
