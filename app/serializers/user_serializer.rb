class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :banned_at, :banned_at, :gravatar_hash,
    :created_at, :updated_at
end
