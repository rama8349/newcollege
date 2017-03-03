# == Schema Information
# Schema version: 94
#
# Table name: states
#
#  id               :integer(11)     not null, primary key
#  state_name       :string(20)      
#  country_id       :integer(11)     not null
#  created_by       :integer(11)     
#  updated_by       :integer(11)     
#  status           :string(15)      
#  state_short_form :string(15)      
#  created_at       :datetime        
#  updated_at       :datetime        
#

class State < ActiveRecord::Base
validates_presence_of(:state_name , :message => "^Please Enter the State Name")
validates_presence_of(:state_short_form , :message => "^Please Enter the State Short Name.")
validates_presence_of(:country_id , :message => "^Please Select the Country Name.")
validates_uniqueness_of(:state_name, :message => "^State Name already Existed", :scope => "state_name")
validates_uniqueness_of(:state_short_form, :message => "^State Short Name already Existed", :scope => "state_short_form")

  validates_format_of(:state_name, :with => /\A[a-zA-Z ]+\z/,:message => "Only letters allowed",:if => Proc.new { |u| u.state_name != "" })
   validates_format_of(:state_short_form, :with => /\A[a-zA-Z ]+\z/,:message => "Only letters allowed",:if => Proc.new { |u| u.state_name != "" }, :allow_blank=>true)
   
belongs_to :country
has_many :city

 def self.find_state(all)
 @state=self.all
 end

end
