class MeController < ApplicationController
  include HasSortableColumns

  def index
    render json: authorize!(:read, current_user)
  end
end
