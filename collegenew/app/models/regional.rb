class Regional < ActiveRecord::Base

has_many :cities
has_many :employees
has_many :crmroles_employees
validates_presence_of(:region_name,:message=>'Should not be blank')
validates_format_of(:region_name, :with => /\A[a-zA-Z\s ]+\z/,:message => "Only letters allowed", :if=>Proc.new{|u| u.region_name != ""})

    def self.find_regional(all)
       @regions = self.all
    end
    
    
    def self.count_delay(req,status_id)
      meet_sla=fail_sla=0
        req.each do |request|
          pending_status = self.turn_delay_request(request,status_id)
           if pending_status=='Yes'
               fail_sla=fail_sla+1
           else
             meet_sla=meet_sla+1
           end
       end
       return meet_sla,fail_sla
    end


  def self.turn_delay_request(delay_obj,status_id)
    begin
      if not status_id.include?(delay_obj.status_id)
        turn_count = Service.find(delay_obj.service_id)
        turn = turn_count.turnaround_time
        if  ((Time.now.to_time)-(turn.to_i * 60 * 60)).strftime("%Y-%m-%d %H:%M:%S")  >= delay_obj.created_at.strftime("%Y-%m-%d %H:%M:%S")
          return 'Yes'
        else
          return 'No'
        end
      else
        return 'No'
      end
    rescue
      return 'No'
    end
    
  end
  




end
