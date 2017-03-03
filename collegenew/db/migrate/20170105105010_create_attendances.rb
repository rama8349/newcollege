class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
t.column:attend_date, :date
t.column:attend_day, :string
t.column:user_id, :int
t.column:created_by, :int
      t.timestamps null: false
    end
  end
end
