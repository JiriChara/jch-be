class ArticlesController < ApplicationController
  include HasSortableColumns

  has_sortable_columns :id, :title, :slug, :content, :published_at, :type,
    :created_at, :updated_at

  has_scope :by_tag, :by_type

  def index
    articles = paginate(sort(search(apply_scopes(Article).all)))

    render json: articles
  end

  def show
    article = Article.find_by!(slug: params[:slug])

    render json: article
  end
end
