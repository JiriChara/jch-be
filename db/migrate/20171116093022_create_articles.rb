class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :slug
      t.text :content
      t.datetime :published_at
      t.string :type
      t.references :user, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
