class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :slug, :content, :published_at, :type, :created_at,
    :user_id, :updated_at

  belongs_to :author
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :name, :slug, :created_at, :updated_at, :banned_at, :gravatar_hash
  end

  has_many :tags
  class TagSerializer < ActiveModel::Serializer
    attributes :id, :name, :slug
  end
end
