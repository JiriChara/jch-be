class ProjectsController < ApplicationController
  include HasSortableColumns

  load_resource find_by: :slug
  authorize_resource

  has_sortable_columns :id, :name, :slug, :description, :url,
    :created_at, :updated_at

  def index
    @projects = paginate(sort(search(apply_scopes(@projects))))

    render json: @projects
  end

  def show
    render json: @project
  end

  def create
    render json: @project, status: 201
  end

  def update
    @project.update!(project_params)

    render json: @project
  end

  def destroy
    @project.destroy!

    head 204
  end

private
  def project_params
    params.require(:project).permit(:name, :slug, :description, :url, :image)
  end
end
