class Project < ApplicationRecord
  include Sluggable

  validates :name, presence: true
  validates :url, presence: true
  validates :description, presence: true
  validates :image, presence: true

  mount_base64_uploader :image, ProjectImageUploader
end
