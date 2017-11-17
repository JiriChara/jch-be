module HasSortableColumns
  extend ActiveSupport::Concern

  class DirectionError < StandardError; end

  included do
    self.sortable_columns = []
  end

  class_methods do
    attr_accessor :sortable_columns

    def has_sortable_columns(*columns)
      self.sortable_columns = columns.map(&:to_sym)
    end
  end

protected
  def sort(target, hash = params)
    if hash[:sort]
      sort = JSON.parse(hash[:sort]).symbolize_keys

      column = sort[:column] || :id
      direction = (sort[:direction] || :asc).downcase.to_sym

      if direction !~ /^asc|desc$/
        raise DirectionError, "The direction must be DESC or ASC. Not #{direction}."
      end

      case target
      when ActiveRecord::Relation
        target.order(
          column => direction
        )
      when Array
        target.sort_by do |item|
          direction === :asc ? column : -column
        end
      else
        target
      end
    else
      target
    end
  end
end
