class Project < ApplicationRecord
  include Sluggable

  validates :name, presence: true
  validates :url, presence: true
  validates :description, presence: true

  mount_base64_uploader :image, ImageUploader, file_name: -> (image) do
    image.name.sub(/\.\w+$/, '')
  end

end
