class TagsController < ApplicationController
  include HasSortableColumns

  load_resource find_by: :slug
  authorize_resource

  has_sortable_columns :id, :name, :slug, :created_at, :updated_at

  def index
    @tags = paginate(sort(apply_scopes(@tags)))

    render json: @tags
  end

  def create
    @tag.save!

    render json: @tag, status: 201
  end

  def update
    @tag.update!(tag_params)

    render json: @tag
  end

private
  def tag_params
    params.require(:tag).permit(:name, :slug)
  end
end
