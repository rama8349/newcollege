class LoginController < ApplicationController
protect_from_forgery except: :authorize



  def index
    redirect_to  controller: 'login',action:'login1', layout: false
  end
  
  def login
  if request.host=="ctssupport.superseva.com"
      redirect_to :controller =>'ctssaml',:target_url=>"#{!params[:target_url].blank? ? params[:target_url] : 'https://ctssupport.superseva.com/customer/user_request_details' }"
    else
    end
  end
  
  
  def login1
    if request.host=="ctssupport.superseva.com"
         redirect_to :controller =>'ctssaml',:target_url=>"#{!params[:target_url].blank? ? params[:target_url] : 'https://ctssupport.superseva.com/customer/user_request_details' }"
       else
       end
     end
       
  
  def authorize 
    #params[:login][:pw]=Employee.hash_password(params[:login][:pw])
   # begin
      reset_session

     if  user = Employee.authenticate(params[:login][:un],params[:login][:pw])

            session[:login_id] = user.id
            session[:login_name] = user.login_name
             session[:role] = 'Administrator'
  @employee = Employee.find(user.id)
#     render :action => 'auth_role' 
#raise @user.id.inspect
#redirect_to(admin_index_path , :id =>user.id)
redirect_to :controller=>'admin', :action=>'index'
else
        redirect_to :controller=>'login', :action=>'login' 
        flash[:message] = 'Please Check User Name and Password.'   
end   
  #rescue
    #redirect_to :controller=>'login', :action=>'login'
    #flash[:message] = 'Please Check User Name and Password.'
   #end
  end
  
  def auth_role
    @employee = Employee.find(params[:id])
#raise @employee.inspect
    @arr = Array.new
    @arr << @employee.role_id
   # crmid=CrmrolesEmployee.find(:all,:conditions=>['employee_id=?',params[:id]])
    #crmid.each do |rol|
    #@arr << rol.crmrole_id
    @arr = @arr.uniq
#raise @arr.inspect
#    end
  end

  def authorize_role
#raise session[:login_id].inspect
    if session[:login_id].blank? || !params.has_key?('employee')
      if session[:login_id].blank?
        flash[:message] = 'Please login to access SuperSeva.'
         redirect_to :action => 'login'
      else
      redirect_to :action => 'auth_role', :id => session[:login_id]
      end 
    else
      employee = Employee.find(session[:login_id]) 
      
        session[:role] = role_name
        session[:city] = city_id
        employee.previous_role_id = employee.role_id
        employee.previous_city_id = employee.city_id
        employee.previous_regional_id = employee.regional_id
        employee.role_id = role_id
        employee.city_id = city_id
        employee.regional_id = region_id
        employee.save(false)
      
    end
  end 

 def logout
  if session[:role] == 'Help Desk'
     e = Employee.find(session[:login_id])
     session[:login_name] = e.login_name
     a=request.remote_ip
     first_name = Employee.find_by_login_name(e.login_name).first_name
     login_detail=LoginDetail.logout_time_save(session[:login_id])
    # login_detail=LoginDetail.sent_mail_for_logout
   else
     e = Employee.find(session[:login_id])
   end
#      if e.role_id == 4
#         scheme = Scheme.find(:first,:conditions=>['employee_id=? and city_id=? and status=?',e.id,e.city_id,'Active'])
#       if scheme and e.previous_scheme_id != nil
#          scheme.employee_id = e.previous_scheme_id
#          scheme.save
#       end    
#     end
     
#      unless (e.previous_role_id.nil? && e.previous_city_id.nil?)   
#      e.role_id = e.previous_role_id
#      e.city_id = e.previous_city_id
#      e.regional_id = e.previous_regional_id
#      e.save(false)
#      end

    reset_session
    session[:login_name] = nil
    session[:role] = nil    
    session[:city] = nil
    session[:uname] = nil
    session[:login_id] =nil
   # session[:requested_for] = nil
#    redirect_to "http://localhost:3000/"
    redirect_to :controller=>'login', :action=>'login' 
  end

 def reward_authorize
    #params[:login][:pw]=Employee.hash_password(params[:login][:pw])
    begin
      reset_session
      login_name=Employee.find(:last,:conditions=>['email_id=? and status=? and role_id in (?)',params[:email],"Active",[21,22,23]])
      if user = Employee.reward_authenticate(login_name.login_name,login_name.hashed_password,login_name.salt)
        if user.crmroles.size > 0
          if (user.crmroles.size==1 && user.crmroles.first.role_name==user.role.role_name)
            session[:login_name] = user.login_name
            session[:role] = user.role.role_name
            session[:city] = user.city.id
            session[:login_id] = user.id
            if session[:role] == 'Help Desk'
               redirect_to :controller=>'process_request', :action=>'help_land'
#              redirect_to :controller=>'admin', :action=>'index'
            else
              redirect_to :controller=>'admin', :action=>'index'
            end
          else
            @employee = Employee.find(user.id)
            @arr = Array.new
            @arr << user.role_id
            crmid=CrmrolesEmployee.find(:all,:conditions=>['employee_id=?',user.id])
            crmid.each do |rol|
            if rol.status=="Active"
              @arr << rol.crmrole_id.to_i
            end
              @arr = @arr.uniq
            end
            session[:login_id] = user.id
            session[:login_name] = user.login_name
            render :action => 'auth_role'
          end
        else
          session[:login_name] = user.login_name
          session[:role] = user.role.role_name
          session[:city] = user.city.id
          session[:login_id] = user.id
          if session[:role] == 'Help Desk'
            redirect_to :controller=>'process_request', :action=>'help_land'
#            redirect_to :controller=>'admin', :action=>'index'
          else
            redirect_to :controller=>'admin', :action=>'index'
          end
        end
      else
        redirect_to :controller=>'login', :action=>'login'
        flash[:message] = 'Please Check User Name and Password.'
      end
    rescue
      redirect_to :controller=>'login', :action=>'login'
      flash[:message] = 'Please Check User Name and Password.'
    end
  end

def logout
     e = Employee.find(session[:login_id])
      if e.role_id == 4
         scheme = Scheme.find(:first,:conditions=>['employee_id=? and city_id=? and status=?',e.id,e.city_id,'Active'])
       if scheme and e.previous_scheme_id != nil
          scheme.employee_id = e.previous_scheme_id
          scheme.save
       end    
     end
     
    

    reset_session
    session[:login_name] = nil
    session[:role] = nil    
    session[:city] = nil
    session[:uname] = nil
    session[:login_id] =nil
   # session[:requested_for] = nil
#    redirect_to "http://localhost:3000/"
    redirect_to :controller=>'login', :action=>'login' 

  end

end
