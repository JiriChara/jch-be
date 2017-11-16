class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :slug, :url, :created_at, :updated_at, :image
end
