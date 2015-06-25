class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter CASClient::Frameworks::Rails::Filter, :except => [ :home_page ]

  #CAS Logout : https://github.com/rubycas/rubycas-client#defining-a-logout-action
  def logout
    @cas_current_user = @extra_attributes = nil
    reset_session
    CASClient::Frameworks::Rails::Filter.logout(self, root_url)
  end

  def get_home_path
    "#{current_user.class.to_s.downcase}_home_path"
  end

  def login
  	if session[:cas_user]
      session[:user] = User.check_for_user(session)
		  redirect_to send(get_home_path) #redirect to home page after navbar is done
    end
  end

 def home_page
    if session[:cas_user]
      redirect_to send(get_home_path)
    end
 end

 def current_user
  User.find_by_user_name(session[:cas_user])
 end

end
