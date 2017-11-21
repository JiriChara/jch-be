class TagsController < ApplicationController
  include HasSortableColumns

  load_resource find_by: :slug
  authorize_resource

  has_sortable_columns :id, :name, :slug, :created_at, :updated_at

  def index
    @tags = paginate(sort(apply_scopes(@tags)))

    render json: @tags
  end
end
