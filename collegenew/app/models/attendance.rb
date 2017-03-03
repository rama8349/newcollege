class Attendance < ActiveRecord::Base
validates_uniqueness_of(:attend_date, :message => "^ Already Assigned for this user", :scope => "attend_date")
  belongs_to :user
  def self.find_user(all)
    @attendance=find(all)
    end
end
