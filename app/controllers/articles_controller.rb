class ArticlesController < ApplicationController
  include HasSortableColumns

  load_resource find_by: :slug
  authorize_resource

  has_sortable_columns :id, :title, :slug, :content, :published_at, :type, :created_at, :updated_at

  has_scope :by_tag
  has_scope :by_type
  has_scope :published, type: :boolean, allow_blank: true

  def index
    @articles = paginate(sort(search(apply_scopes(@articles))))

    render json: @articles
  end

  def show
    render json: @article
  end

  def create
    @article.user = current_user
    @article.save!

    render json: @article, status: 201
  end

  def update
    @article.update!(update_params)

    render json: @article
  end

  def destroy
    @article.destroy!

    head 204
  end

private
  def create_params
    params.require(:article).permit(:title, :slug, :content, :published_at, :type, :images)
  end

  def update_params
    params.require(:article).permit(:title, :slug, :content, :published_at, :type, :images, :tag_list)
  end
end
