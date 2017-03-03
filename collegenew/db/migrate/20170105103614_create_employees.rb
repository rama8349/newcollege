class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
t.column:first_name, :string
      t.column:middle_name, :string, :null => false
      t.column:last_name, :string, :null => false
      t.column:nick_name, :string, :null => false  
      t.column:login_name, :string, :null => false
      t.column:address1, :string
      t.column:address2, :string
      t.column:address3, :string
      t.column:gender, :string
      t.column:date_of_birth, :string
      t.column:contact_number, :string, :null => false
      t.column:marital_status, :string
      t.column:hobbies, :string
      t.column:role_id, :int, :null=>false
      t.column:city_id, :int, :null=>false
      t.column:created_by, :int
      t.column:updated_by, :int
      t.column:status, :string, :default => 'Active'
      t.column:hashed_password, :string
      t.column:salt, :string
      t.column:email_id, :string
      t.timestamps null: false
    end
  end
end
