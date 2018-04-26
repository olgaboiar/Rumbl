class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :screen_name
      t.string :email
      t.string :userpic
      t.date :birthday
      t.string :password
    end
  end
end
