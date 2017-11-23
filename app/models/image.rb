class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  validates :name, presence: true

  mount_base64_uploader :file, ImageUploader, file_name: -> (image) do
    image.name.sub(/\.\w+$/, '')
  end

  scope :by_imageable_type, -> (type) do
    Image.where(imageable_type: type)
  end

  scope :by_imageable_id, -> (id) do
    Image.where(imageable_id: id)
  end
end
