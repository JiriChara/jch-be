module Sluggable
  extend ActiveSupport::Concern

  included do
    before_create :set_slug
    validates :slug, uniqueness: true
  end

private
  def set_slug
    sluggables = [:name, :title]

    sluggable = sluggables.find(&self.method(:respond_to?))

    self.slug = if sluggable
      slug_exists = false
      loop do
        slug = send(sluggable).parameterize + (
          slug_exists ? "-#{SecureRandom.hex(6)}" : ''
        )
        slug_exists = self.class.find_by(slug: slug).present?
        break slug unless slug_exists
      end
    else
      SecureRandom.hex
    end
  end
end
