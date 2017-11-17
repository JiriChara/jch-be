class ProjectsController < ApplicationController
  include HasSortableColumns

  has_sortable_columns :id, :name, :slug, :description, :url,
    :created_at, :updated_at

  def index
    projects = paginate(sort(search(apply_scopes(Project).all)))

    render json: projects
  end

  def show
    project = Project.find_by!(slug: params[:slug])

    render json: project
  end

  def create
    project = Project.create!(project_params)

    render json: project, status: 201
  end

  def update
    project = Project.find_by!(slug: params[:slug])

    project.update(project_params)

    render json: project
  end

  def destroy
    project = Project.find_by!(slug: params[:slug])

    project.destroy!

    head 204
  end

private
  def project_params
    params.require(:project).permit(:name, :slug, :description, :url, :image)
  end
end
