class CreateColleges < ActiveRecord::Migration
  def change
    create_table :colleges do |t|
t.string :college_name
      t.string :college_short_name
      t.string :address
      t.date :establish_date
      t.string :status
      t.timestamps null: false
    end
  end
end
