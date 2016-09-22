class CreateTableImageCategories < ActiveRecord::Migration
  def change
    create_table :image_categories do |t|
      t.integer :image_id
      t.integer :category_id
    end
  end
end
