class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
t.column:first_name, :string
t.column:sur_name, :string
t.column:email, :string
t.column:confirm_email, :string
t.column:pasword, :string
t.column:day, :int
t.column:month, :int
t.column:year, :int
t.column:gender, :string
t.column:upload_photo, :boolean
t.column:attend_date, :date
t.column:provider, :string
t.column:uid, :string
t.column:name, :string
t.column:oauth_token, :string
t.column:oauth_expires_at, :datetime
t.column:type_of_login,:string
      t.timestamps null: false
    end
  end



end
