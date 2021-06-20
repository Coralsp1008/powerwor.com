class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :word
      t.string :speaker
      t.text :about
      t.string :image

      t.timestamps
    end
  end
end
