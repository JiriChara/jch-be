class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :slug
      t.string :role
      t.datetime :banned_at
      t.string :password_digest
      t.string :image_url

      t.timestamps
    end
  end
end