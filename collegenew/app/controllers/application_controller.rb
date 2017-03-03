class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 protect_from_forgery with: :exception
 # protect_from_forgery
#require 'twitter' 

def authorize
 #raise session[:login_name].inspect
session_length = 4000 #30 Minutes for logged in users
    expire_time = session[:expire_time] || Time.now + 4000 
    if (session[:login_name].blank? && !params[:SAMLResponse].blank? && expire_time > Time.now)
     redirect_to(:controller => "ctssaml" , :action => "index",:SAMLResponse=>params[:SAMLResponse],:target_url=>"#{request.url}" )
    else

      if not session[:login_name] 
        if session[:role] == 'User'
        reset_session     
        session[:role] == 'User'
        request.host.include?("ctssupport.superseva.com") ? redirect_to(:controller =>'ctssaml') : redirect_to(:controller => "user_login" , :action => "logout" )
        else
        reset_session
        flash[:message] = "Please Login"
        redirect_to(:controller => "login" , :action => "login",:target_url=>"#{request.url}" )
        end
        
        elsif expire_time < Time.now 
         if session[:role] == 'User'
         reset_session
         session[:role] == 'User'
        flash[:message] = "Session Expired..."
        redirect_to(:controller => "user_login" , :action => "logout" ) 
        else 
        reset_session
        flash[:message] = "Session Expired..."
        redirect_to(:controller => "login" , :action => "login",:target_url=>"#{request.url}" )
        end
        
      end
   end
    session[:expire_time] = Time.now + session_length 
  end


private

def current_user
  @current_user ||= User.find(session[:login_id]) if session[:login_id]
end
helper_method :current_user

end
