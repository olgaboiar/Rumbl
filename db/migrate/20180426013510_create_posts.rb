class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :title
      t.text :subtitle
      t.string :picture
      t.text :postbody
      t.integer :user_id
      t.timestamp :time_created
    end
  end
end
