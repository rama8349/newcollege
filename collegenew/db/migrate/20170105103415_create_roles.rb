class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
 t.column:role_name, :string, :limit=>25
      t.column:role_short_name, :string, :limit=>25      
      t.column:created_by, :int, :limit=>25
      t.column:updated_by, :int, :limit=>25
      t.column:status, :string, :limit=>15
      t.timestamps null: false
    end
  end
end
