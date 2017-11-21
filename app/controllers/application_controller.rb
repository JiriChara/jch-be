class ApplicationController < ActionController::API
  include Knock::Authenticable

  check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: 'Forbidden' }, status: 403
  end

protected
  def search(target, hash = params)
    query = hash[:q]

    query ? target.search_for(query) : target.all
  end
end
