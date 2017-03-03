class SessionController < ApplicationController
def create

    user = User.from_omniauth(env["omniauth.auth"])
    session[:login_id] = user.id
  session[:role]=user.type_of_login
session[:email]=user.email
    redirect_to :controller=>'admin', :action=>'index'
  end

  def destroy
    session[:login_id] = nil
    redirect_to root_url
  end

 

end
