# == Schema Information
# Schema version: 94
#
# Table name: cities
#
#  id              :integer(11)     not null, primary key
#  city_name       :string(25)      
#  state_id        :integer(11)     not null
#  city_short_form :string(15)      
#  created_by      :integer(11)     
#  updated_by      :integer(11)     
#  status          :string(15)      
#  created_at      :datetime        
#  updated_at      :datetime        
#

class City < ActiveRecord::Base
validates_presence_of(:city_name , :message => "^Please Enter the City Name")
validates_presence_of(:city_short_form , :message => "^Please Enter the City Short Name.")
validates_presence_of(:state_id , :message => "^Please Select the State Name.")

validates_uniqueness_of(:city_name, :message => "^City Name already Existed", :scope => "city_name")
validates_uniqueness_of(:city_short_form, :message => "^City Short Name already Existed", :scope => "city_short_form")
validates_format_of :city_name, :with=>/\A[a-zA-Z\- ]+\Z/, :message=>"Only letters allowed", :allow_nil=>true, :allow_blank=>true

belongs_to :state
has_many :employees
has_many :subdivison
has_many :sub_division
has_many :schemes
belongs_to :regional

has_many :crmroles_employees


 
 def self.find_city(all)
 @city=self.all
 end
 
    def self.serach_by_criteria(condition, values)
    final_condition= sanitize_sql([condition] + values)
    @schemes = find(:all, :conditions => final_condition)
   end

end

