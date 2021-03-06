class Country < ActiveRecord::Base
validates_presence_of(:country_name , :message => "^Please Enter the Country Name")
validates_presence_of(:country_short_form , :message => "^Please Enter the Short Name.")
validates_uniqueness_of(:country_name, :message => "^Country Name already Existed", :scope => "country_name")
validates_uniqueness_of(:country_short_form, :message => "^Country Short Name already Existed", :scope => "country_short_form")
validates_format_of :country_name, :with=>/\A[a-zA-Z\s]+\Z/, :message=>"only letters allowed", :allow_blank=>true
has_many:states

def self.find_country(id)
   @country=find(id)
 end 
 
 def self.find_country(all)
 @country=self.all
 end
end
