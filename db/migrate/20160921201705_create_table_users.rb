class CreateTableUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :like_id
      t.integer :dislike_id
      t.integer :category_id
    end
  end
end
