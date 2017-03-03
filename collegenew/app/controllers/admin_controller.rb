class AdminController < ApplicationController
before_filter :authorize, :except=>['index']
  #before_filter :use_user_stamp
  
  layout :choose_layout
  
  def choose_layout
    if (session[:role]=="Admin" || session[:role]=="Manager" || session[:role]=="Employee")
       'SuperSevaAdminNew'
    else
       'SuperSevaAdmin'
    end
  end
  
 def index 
        if session[:role]=="Help Desk" or session[:role]=="Support User" or session[:role]=="Administrator"
    session[:requested_for] = ""
 render :action => "home"
        elsif session[:role]=="user" ||session[:role]=="facebook" ||session[:role]=="twitter"
      render :action => "home"
        end
 
  end
 def indexcity
    render :action => "savecity"
  end
  
  def savecity
    @city=City.new(params.require(:city).permit(:city_name,:state_id,:city_short_form,:regional_id))
    if @city.save     
      redirect_to :action=>'showcity'
    else
      
    end
    
  end
  
  def showcity
    #Audit.capture(:component=>request.request_uri ,:session=>session,:params=>params)
   # @session_uname=get_uname
  # @session_role =get_role
    #@session_city =get_city
   # @role_short_name = session[:role_short_name]
    @city = City.all
  end
  
  def destroycity
    @city = City.find_city(params[:id])
    @city.destroy
    redirect_to :action=>'showcity'    
  end
  
  def detailscity
    @city = City.find(params[:id])
  end
  
  def editcity
    @city=City.find(params[:id])
  end 
  
  def updatecity
    @city = City.find(params[:id])
    if @city.update_attributes(params[:city])
      #Audit.capture(:component=>request.request_uri ,:session=>session,:params=>params)  
      flash[:notice] = 'City Name has been updated successfully.'      
      redirect_to :action=>'showcity' 
    else
      render :action => 'editcity'
    end

  end
  
  def scheme_city
  
  end
  
#  @fromdate=params[:service][:from_date].to_date.strftime("%Y-%m-%d")
#    @enddate=params[:service][:to_date].to_date.strftime("%Y-%m-%d")
#    service = params[:service][:id]
#    @accounts = TransactionDetail.servicecharge_sum(@fromdate,@enddate,service)
#    render :action=>'service_report'
  
  def city_search
  
  city = params[:city][:city_name]
  status = params[:city][:status]
   @city = City.find_by_sql("select * from cities where city_name like '%#{city}%' and status = '#{status}'")
    render :action=>'showcity'
    #Audit.capture(:component=>request.request_uri ,:session=>session,:params=>params)  
    end
  
  
  def indexcountry
    render :action=>"savecountry"
  end
  
  def savecountry
    @country=Country.new(params.require(:country).permit(:country_name, :country_short_form))
    if @country.save
      redirect_to :action=>'showcountry'
    else
      
    end       
  end
  
  def showcountry
    @country=Country.find_country(:all) 
  end
  
  def editcountry
    @country=Country.find(params[:id])
  end 
  
  def updatecountry
  #Audit.capture(:component=>request.request_uri ,:session=>session,:params=>params)
    @country = Country.find(params[:id])
    if @country.update_attributes(params.require(:country).permit(:country_name, :country_short_form))
      flash[:notice] = 'Country Name has been updated successfully.'       
    else
      flash[:notice] = 'Country Name has been updated successfully.'      
    end
    redirect_to :action=>'showcountry'
  end
  
  def destroycountry
    @country = Country.find(params[:id])
    @country.destroy
    redirect_to :action=>'showcountry'
  end
  
  def detailscountry
    @country = Country.find(params[:id])
  end
  
  
  def indexstate
    render :action=>"savestate"
  end
  
  def savestate
@state=State.new(params.require(:state).permit(:state_name,:country_id, :state_short_form))
    if @state.save   
      flash[:notice] = 'State Name has been created successfully.' 
      redirect_to :action=>'showstate'    
    else   
    end   
  end
  
  def showstate
    @state=State.find_state(:all)
  end
  
  def destroystate
    @state=State.find_state(params[:id])
    @state.destroy
    redirect_to :action=>'showstate'
  end
  
  def detailsstate
    @state = State.find(params[:id])
  end
  
  def editstate
    @state=State.find(params[:id])
  end 
  
  def updatestate
    @state = State.find_state(params[:id])
    if @state.update_attributes(params[:state])
      flash[:notice] = 'State Name has been updated successfully.'       
    else
      flash[:notice] = 'State Name has been updated successfully.'      
    end
    redirect_to :action=>'showstate'
   #Audit.capture(:component=>request.request_uri ,:session=>session,:params=>params)   
  end
 

def newregional
    @regional = Regional.new
    end

   def createregion
    @regional = Regional.new(params.require(:regional).permit(:region_name))
    if @regional.save
    flash[:notice] = 'Region Name has been created sucessfully'
    redirect_to :action => 'showregion'
    else
    flash[:notice] = @regional.errors.full_messages.join(", ")
    render :action => 'newregional'
    end 
    end

   def showregion
    @regions = Regional.all
    end

   def editregion
    @regional = Regional.find(params[:id])
    end

    def updateregion
    @regional = Regional.find(params[:id])
    if @regional.update_attributes(params.require(:regional).permit(:region_name))
      flash[:notice] = 'Region Name has been updated sucessfully'
      redirect_to :action => 'showregion'
      else
      render :action => 'editregion'
      end
    end	
    
    
    
    
    
    
def newcollege
  @college = College.new
end
def indexcollege
@fromdate = 1.week.ago.strftime("%d-%m-%Y")
render :action=>"savecollege"
end
def showcollege
  @college = College.all
end
def savecollege
  @college=College.new(params.require(:college).permit(:college_name,:college_short_name,:establish_date,:address,:status))
   if @college.save
    redirect_to :action=>'showcollege'
    else
 end
end

def editcollege
  @college = College.find(params[:id])
end
def updatecollege
  @college = College.find(params[:id])
     if @college.update_attributes(params.require(:college).permit(:college_name,:college_short_name,:establish_date,:address,:status))
       flash[:notice] = 'College Name has been updated successfully.'       
     else
       flash[:notice] = 'College Name has been updated successfully.'      
     end
     redirect_to :action=>'showcollege'
end

############# for attendance functionality #####################################

  def show_assign_user_attendance
   @attendance=Attendance.all
  end
  def assign_user_attendance
    @fromdate=Date.today
   @emp=Employee.find(session[:login_id])
     @user=User.all
     @today_date=DateTime.now.strftime('%Y-%m-%d')
     #@attandance=Attendance.last
    #@attandance_date= @attandance.attend_date.strftime('%Y-%m-%d') 
      
  end
  def assign_att
    params[:att].each_with_index do |vd,i|
    @attendance =  Attendance.create(:attend_date=>vd[1][:attend_date],:user_id=>vd[1][:user_id],:created_by=>vd[1][:created_by],:attend_day=>vd[1][:attend_day])
@attendance.save
    end
      flash[:notice]="Attendance assigned successfully"
        redirect_to :action=>'show_assign_user_attendance'
  end

  def show_attendance
    @user=User.find_by_sql("select * from  users as u inner join attendances as  at  on u.id=at.user_id where u.id=at.user_id")
    #raise @user.inspect
  end


end
