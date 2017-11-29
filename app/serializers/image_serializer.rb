class ImageSerializer < ActiveModel::Serializer
  attributes :id, :file, :name, :imageable_id, :imageable_type, :created_at, :updated_at
end
