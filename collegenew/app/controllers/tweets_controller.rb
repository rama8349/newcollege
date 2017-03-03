class TweetsController < ApplicationController
layout :choose_layout 

def choose_layout
  session[:role]="user"
    if (session[:role]=="Admin" || session[:role]=="Manager" || session[:role]=="Employee")
       'SuperSevaAdminNew'
    else
       'SuperSevaAdmin'
    end
  end

def new
#binding.pry
  end

  def create
    current_user.tweet(twitter_params[:message])
  end

  def twitter_params
    params.require(:tweet).permit(:message)
  end

def search_tweet
@tweets = $client.search("@#{params[:search]}", result_type: "recent",:created_at=>"Date.yesterday").attrs[:statuses].reverse rescue []
    @tweets = Kaminari.paginate_array(@tweets).page(params[:page]).per(10)
end


end


