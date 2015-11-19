class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :message
      t.integer :user_id
      t.string :title
      t.boolean :published, default: true

      t.timestamps
    end
  end
end
