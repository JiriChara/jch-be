class ImagesController < ApplicationController
  include HasSortableColumns

  load_and_authorize_resource

  has_sortable_columns :id, :imageable_type, :imageable_id, :created_at, :updated_at

  has_scope :by_imageable_id
  has_scope :by_imageable_type

  def index
    @images = paginate(sort(search(apply_scopes(@images))))

    render json: @images
  end

  def create
    @image.save!

    render json: @image, status: 201
  end

  def destroy
    @image.destroy!

    head 204
  end

private
  def image_params
    params.require(:image).permit(:name, :file, :imageable_type, :imageable_id)
  end
end
