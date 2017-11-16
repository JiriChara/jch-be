class TagsController < ApplicationController
  include HasSortableColumns

  has_sortable_columns :id, :name, :slug, :created_at, :updated_at

  def index
    tags = paginate(sort(apply_scopes(Tag).all))

    render json: tags
  end
end
