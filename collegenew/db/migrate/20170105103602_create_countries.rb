class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
t.column:country_name, :string, :limit=>25
      t.column:created_by, :int, :limit=>25
      t.column:updated_by, :int, :limit=>25
      t.column:country_short_form,:string, :limit=>15
      t.column:status, :string, :limit=>15

      t.timestamps null: false
    end
  end
end
