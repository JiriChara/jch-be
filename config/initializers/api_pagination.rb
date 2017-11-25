ApiPagination.configure do |config|
  config.paginator = :kaminari

  config.total_header = 'x-total'
  config.per_page_header = 'x-per-page'
  config.page_header = 'x-page'

  config.page_param do |params|
    if params[:page].present?
      page = JSON.parse(params[:page]).symbolize_keys
      page && page[:number]
    end
  end

  config.per_page_param do |params|
    if params[:page].present?
      page = (JSON.parse(params[:page]) || {}).symbolize_keys
      page && page[:size]
    end
  end
end
