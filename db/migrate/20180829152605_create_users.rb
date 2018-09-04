class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :mail
      t.string :password
      t.string :token
      t.string :salt
      t.timestamps
    end
  end
end
