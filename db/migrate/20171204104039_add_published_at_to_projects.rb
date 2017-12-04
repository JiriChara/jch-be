class AddPublishedAtToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :published_at, :datetime
  end
end
