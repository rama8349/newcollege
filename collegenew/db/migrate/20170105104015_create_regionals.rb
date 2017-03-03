class CreateRegionals < ActiveRecord::Migration
  def change
    create_table :regionals do |t|
t.column:region_name, :string
      t.column:created_by,:int
      t.column:updated_by,:int 
      t.timestamps null: false
    end
  end
end
