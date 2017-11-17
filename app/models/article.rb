class Article < ApplicationRecord
  belongs_to :user

  include Sluggable
  include Taggable
  include PgSearch

  default_scope { order(created_at: :desc) }

  scope :by_tag, -> (name) do
    tag = Tag.find_by(name: name)
    tag ? tag.articles : Article.none
  end

  pg_search_scope :search_for,
    against: %i(title content)

  paginates_per 5

  def publish!
    update(published_at: Time.now.utc)
  end

  def unpublish!
    update(published_at: nil)
  end

  def published?
    published_at.present?
  end

  def author
    user
  end

  def to_param
    slug
  end
end
