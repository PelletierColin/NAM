class CreateMissions < ActiveRecord::Migration[5.1]
  def change
    create_table :missions do |t|
      t.string :project_name
      t.text :description
      t.datetime :starting_date
      t.datetime :ending_date
      t.references :user
      t.timestamps
    end
  end
end
