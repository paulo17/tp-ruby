class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :post_id
      t.string :url

      t.timestamps null: false
    end
  end
end
