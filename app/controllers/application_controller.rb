class ApplicationController < ActionController::API
  include Knock::Authenticable

protected
  def search(target, hash = params)
    query = hash[:q]

    query ? target.search_for(query) : target.all
  end
end
