module Sluggable
  extend ActiveSupport::Concern

  included do
    before_create :set_slug
  end

private
  def set_slug
    sluggables = [:name, :title]

    sluggable = sluggables.find(&self.method(:respond_to?))

    self.slug = sluggable ? send(sluggable).parameterize : SecureRandom.hex
  end
end
