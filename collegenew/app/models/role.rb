# == Schema Information
# Schema version: 94
#
# Table name: roles
#
#  id              :integer(11)     not null, primary key
#  role_name       :string(25)      
#  role_short_name :string(25)      
#  created_by      :integer(11)     
#  updated_by      :integer(11)     
#  status          :string(15)      
#  created_at      :datetime        
#  updated_at      :datetime        
#

class Role < ActiveRecord::Base
  has_many :employees
  
  
  validates_presence_of(:role_name, :message => "^Please Enter Role Name.")
  validates_presence_of(:role_short_name, :message => "^Please Enter Role Short Name.")
  validates_format_of(:role_name, :with => /\A[a-zA-Z\- ]+\z/, :allow_blank => true, :allow_nil => true , :message => "Only letters allowed")
  validates_format_of(:role_short_name, :with => /\A[a-zA-Z\-\s]+\z/,:allow_blank => true, :allow_nil => true ,:message => "Only letters allowed")
  validates_uniqueness_of :role_name, :message=>"already exists", :if=>Proc.new{|r| r.status=="Active"}
  #  def get_employee role_id
  #    self.employees.find_all_by_role_id(role_id)
  #  end
  
  def self.find_role(id)
    @role=find(id)
  end 
  
  def self.find_role(all)
    @role=find(all)
  end
  
end
