	# == Schema Information
	# Schema version: 94
	#
	# Table name: employees
	#
	#  id                 :integer(11)     not null, primary key
	#  first_name         :string(255)     
	#  middle_name        :string(255)     not null
	#  last_name          :string(255)     not null
	#  nick_name          :string(255)     not null
	#  login_name         :string(255)     not null
	#  address1           :string(255)     
	#  address2           :string(255)     
	#  address3           :string(255)     
	#  gender             :string(255)     
	#  date_of_birth      :string(255)     
	#  contact_number     :string(255)     not null
	#  marital_status     :string(255)     
	#  hobbies            :string(255)     
	#  role_id            :integer(11)     not null
	#  city_id            :integer(11)     not null
	#  created_by         :integer(11)     
	#  updated_by         :integer(11)     
	#  status             :string(255)     default("Active")
	#  hashed_password    :string(255)     
	#  salt               :string(255)     
	#  created_at         :datetime        
	#  updated_at         :datetime        
	#  employee_type_id   :integer(11)     
	#  employee_type_type :string(255)     
	#

	#require 'digest/sha1'
	#require 'spreadsheet/excel'
	#  require 'parseexcel'
	#  require 'parseexcel/parseexcel'
	#  require 'parseexcel/parser'

	class Employee < ActiveRecord::Base
	  belongs_to :employee_type,:polymorphic=>true
	  belongs_to :role
	  belongs_to :regional
	  belongs_to :city
	  has_many :schemes
	  has_many :crm_schemes
	  has_many :crm_monthly_plan
	  has_many :crm_weekly_plan
	  has_and_belongs_to_many :services
	  has_many :vendor_details
	  has_many :recent_download_users
	 # has_many :crmroles_employees
	  has_and_belongs_to_many :crmroles   
	   validates_presence_of(:first_name , :message => "^Please Enter First Name.")
	   validates_format_of(:first_name, :with => /\A[a-zA-Z\s]+\z/,:message => "Only letters allowed",:if=>Proc.new{|u| u.first_name!=""})
	   validates_presence_of(:login_name, :message => "^Please Enter Login Name.")
	   validates_presence_of(:address1, :message => "^Please Enter Address1.")
	   #validates_presence_of(:date_of_birth, :message => "^Please Enter Date Of Birth.")
	#   validates_presence_of(:contact_number, :message => "^Please Enter Contact Number.")  
	  validates_presence_of(:email_id, :message => "^Please Enter Email.") 

	  validates_format_of :email_id, :with => /\A([^@,\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,:if=>Proc.new{|u| u.email_id != ""}
	#  validates_presence_of   :role_id,    :message => "^Please Select Role",
	# :if => Proc.new { |u| u.role_id == nil or u.role_id ==""} 
	 
	 validates_presence_of   :city_id,    :message => "^Please Select City",
	 :if => Proc.new { |u| u.city_id == nil or u.city_id ==""} 
	 
	  validates_presence_of   :gender,    :message => "^Please Select Gender",
	 :if => Proc.new { |u| u.gender == nil or u.gender =="" } 
	 
	 # validates_presence_of   :marital_status,    :message => "^Please Select Marital Status",
	# :if => Proc.new { |u| u.marital_status == nil or u.marital_status =="" }
	  
	  validates_uniqueness_of(:login_name, :message => "^Login Name already Existed", :scope => "login_name")
	#  validates_format_of :contact_number,
	#                       :with=>/^[\d\s]{1,10}$/i,
	#:message => "^invalid contact number"

	validates_presence_of(:password , :message => "^Please Enter password.")
	validates_presence_of(:password_confirmation , :message => "^Please Enter confirm password.")

	#validates_format_of :login_name, :with=>/\A[a-zA-Z0-9- ]+\Z/, :message=>"Only letters allowed", :allow_nil=>true, :allow_blank=>true
	validates_length_of       :contact_number,    :within => 10..10,:allow_blank=>true, :message=>'is too short(minimum 10)'
	  
	   MARITAL_STATUS = [
	   ["Single",   "No"],
	   ["Married", "Yes"]
	   ]
	   
	   
	    VENDOR_PAY = [
	   ["Immidiate", "Immidiate"], 
	   ["Weekly",   "Weekly"],
	   ["Monthly", "Monthly"],
	   ["Yearly",   "Yearly"]
	   ]
	   
	   
	   
	  
	   GENDER_TYPES = [
	   ["Male",   "M"],
	   ["Female", "F"]
	   ]
	     
	    DESK_TYPES = [
	   ["Yes","Yes"],
	   ["No","No"]
	   ]
	  

	  attr_accessor :password_confirmation

	  validates_confirmation_of :password
	  
	  def validate
	    errors.add_to_base("Missing password" ) if hashed_password.blank?
	  end
	  
	  def self.authenticate(login_name, password)
	    employee = self.find_by login_name: login_name,status: 'Active'
#raise employee.status.inspect	  
  if employee
	      expected_password = encrypted_password(password, employee.salt)
  if employee.hashed_password != expected_password
		employee = nil
	      end
	      if employee.status == "In-Active"
		employee = nil  
	      end
	    end
	    employee
	  end

	  def self.reward_authenticate(login_name, password,salt)
	    employee = self.find_by_login_name(login_name,:conditions=>['status=?','Active'])
	    if employee
	      expected_password = encrypted_password(password, salt)
	      if employee.hashed_password != expected_password
		employee = employee
	      end

	      if employee.status == "In-Active"
		employee = nil
	      end
	    end
	    employee
	  end
	  
	  # 'password' is a virtual attribute
	  def password
	    @password
	  end
	  def password=(pwd)
	    @password = pwd
	    return if pwd.blank?
	    create_new_salt
	    self.hashed_password = Employee.encrypted_password(self.password, self.salt)
	  end

	  private
	  def self.encrypted_password(password, salt)
	    string_to_hash = password + "wibble" + salt # 'wibble' makes it harder to guess
	    Digest::SHA1.hexdigest(string_to_hash)
	  end
	  
	  def create_new_salt
	    self.salt = self.object_id.to_s + rand.to_s
	  end 
	  
	  def self.find_employee(id)
	   @employee=find(id)
	 end 
	 
	 def self.find_employee(all)
	 @employee=find(all)
	 end
	  
	  def self.find_vendorservices(employee_id)
	  role=Role.find_by_role_name('Vendor')
	  find(:all,:conditions=>["role_id=? and id =?",role.id,employee_id])
	  end
	   def self.serach_by_email(condition,values)   
	    final_condition= sanitize_sql([condition] + values)
	    @employee = find(:all, :conditions => final_condition,:order=>'login_name')
	   end

	  def self.pending(scheme_id)
	  scheme = Scheme.find(scheme_id)
	  if scheme.subscription_valid_upto && Time.now >= scheme.subscription_valid_upto.months_ago(1) and Time.now <= scheme.subscription_valid_upto
	     return scheme
	  end   
	  end


	  
	end
