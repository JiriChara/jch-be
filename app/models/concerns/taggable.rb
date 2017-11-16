module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :taggings, as: :taggable
    has_many :tags, through: :taggings
  end

  def tag(name)
    name.strip!
    tag = Tag.find_or_create_by(name: name)
    self.taggings.find_or_create_by(tag_id: tag.id)
    tag
  end

  def tag_names
    tags.collect(&:name)
  end

  def tag_names=(names)
    self.tags = names.split(',').map do |t|
      self.tag(t)
    end
  end
end
