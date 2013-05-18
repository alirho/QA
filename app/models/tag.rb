class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :questions, through: :taggings
end
