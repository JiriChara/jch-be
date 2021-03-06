class Tag < ApplicationRecord
  has_many :taggings
  has_many :articles, through: :taggings, source: :taggable, source_type: 'Article'

  validates_uniqueness_of :name

  include Sluggable
end
