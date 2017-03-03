class Sendmail < ApplicationMailer
def user_sign_up(user)
    mail(:to => user.email, :subject => "Registered")
end

end
