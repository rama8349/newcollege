class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
t.column:state_name, :string, :limit=>20
      t.column:country_id, :int, :null=>false      
      t.column:created_by, :int, :limit=>25
      t.column:updated_by, :int, :limit=>25      
      t.column:status, :string, :limit=>15
      t.column:state_short_form, :string, :limit=>15

      t.timestamps null: false
    end
  end
end
