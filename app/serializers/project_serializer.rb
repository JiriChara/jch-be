class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :slug, :url, :image, :published_at, :created_at, :updated_at
end
