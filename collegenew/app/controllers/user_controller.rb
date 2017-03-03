class UserController < ApplicationController
 layout :choose_layout ,:except=>['logout','login','new_user']
  protect_from_forgery except: :authorize

def choose_layout
  session[:role]="user"
    if (session[:role]=="Admin" || session[:role]=="Manager" || session[:role]=="Employee")
       'SuperSevaAdminNew'
    else
       'SuperSevaAdmin'
    end
  end
 
  def login
  if request.host=="ctssupport.superseva.com"
      redirect_to :controller =>'ctssaml',:target_url=>"#{!params[:target_url].blank? ? params[:target_url] : 'https://ctssupport.superseva.com/customer/user_request_details' }"
    else
    end
  end
  
  
  def logout
    reset_session
        session[:login_name] = nil
        session[:role] = nil    
        session[:city] = nil
        session[:uname] = nil
        session[:login_id] =nil
        redirect_to :controller=>'user', :action=>'login' 
  end  
  
  def new_user
    @user=User.new
  end
  
  def createuser
    @user=User.new(user_params)
    # session[:login_id]=@user.id
     @user.save
     Sendmail.user_sign_up(@user).deliver
     
     flash[:notice]="user created succesfully"
    redirect_to :controller=>'user', :action=>'show_user',:login_id=>@user.id
  end
  def show_user


   # raise session[:login_id].inspect
    if session[:login_id].blank?
    session[:login_id]=params[:login_id]
@user=User.where(:id => session[:login_id]).first
else
   @user=User.where(:id => session[:login_id]).first
end 
  
   
  #  @data=User.find(:all)
  end
  
  def authorize   
   # raise params.inspect
     #params[:login][:pw]=Employee.hash_password(params[:login][:pw])
    # begin
       reset_session
      if  user = User.authenticate(params[:login][:email],params[:login][:pw])
               session[:login_id] = user.id
              session[:login_name] = user.email
                session[:role] = "user"
          #raise session[:role].inspect 
             @user = User.find(user.id)
 #     render :action => 'auth_role' 
 redirect_to :controller=>'admin', :action=>'index'
 else
         redirect_to :controller=>'user', :action=>'login' 
         flash[:message] = 'Please Check User Name and Password.'   
 end   
   #rescue
     #redirect_to :controller=>'login', :action=>'login'
     #flash[:message] = 'Please Check User Name and Password.'
    #end
   end
   def search_college
     @college=College.find(:all)
   end
   
   def uploadFile
   # raise params[:upload][:contractcopy].original_filename.inspect
     @user=User.find(params[:id])
#raise @user.first_name.inspect
o_name = params[:upload][:contractcopy].original_filename.split('.')
#raise o_name.inspect         
     a_name = @user.first_name.to_s+'.'+o_name[1]
              directory = "public/user/photos/"
              path = File.join(directory, a_name)
              File.open(path, "wb") { |f| f.write(params[:upload][:contractcopy].read) }
             # invoice.update_attributes(:sent_invoice=>'yes',:uploaded_receivings=>'yes',:remarks=>params["remarks"][sch_id],:payment_received=>payment_r
@user.update_attributes(:upload_photo=>a_name)
        flash[:notice] = "File has been uploaded successfully"
        redirect_to :action=>'show_user'
  end
  def download_uploaded_documents
    Dir["#{::Rails.root}/public/user/photos/*"].each do |x|
          if File.basename(x).include?(params[:file])
            send_file x
          end
        end
    
  end
 def  logout
reset_session
    session[:login_name] = nil
    session[:role] = nil    
    session[:city] = nil
    session[:uname] = nil
    session[:login_id] =nil
   # session[:requested_for] = nil
#    redirect_to "http://localhost:3000/"
    redirect_to :controller=>'user', :action=>'login' 

end

def java_script
end

################# for private accesables ##########
private 

def user_params

params.require(:user).permit(:first_name, :sur_name,:email,:confirm_email,:pasword,:day,:month,:year,:gender)
end



end
