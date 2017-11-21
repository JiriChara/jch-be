class Article < ApplicationRecord
  belongs_to :user

  include Sluggable
  include Taggable
  include PgSearch

  scope :by_tag, -> (name) do
    tag = Tag.find_by(name: name)
    tag ? tag.articles : Article.none
  end

  scope :by_type, -> (type) do
    Article.where(type: type)
  end

  scope :published, -> (value = true) do
    value ? where.not(published_at: nil) : where(published_at: nil)
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
