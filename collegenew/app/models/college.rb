class College < ActiveRecord::Base

validates_presence_of(:college_name , :message => "^Please Enter the College Name")
validates_presence_of(:college_short_name , :message => "^Please Enter the Short Name.")
validates_uniqueness_of(:college_name, :message => "^College Name already Existed", :scope => "college_name")
validates_uniqueness_of(:college_short_name, :message => "^College Short Name already Existed", :scope => "college_short_name")
validates_format_of :college_name, :with=>/\A[a-zA-Z\s]+\Z/, :message=>"only letters allowed", :allow_blank=>true
validates_presence_of(:status , :message => "^Please Select Status")
validates_presence_of(:establish_date , :message => "^Please Select Establish Date")

def self.find_college(id)
   @college=find(id)
 end 
 
def self.find_college(all)
   @college=find(all)
 end
end
