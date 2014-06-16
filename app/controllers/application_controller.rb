class ApplicationController < ActionController::Base
  protect_from_forgery

  #CAS Logout : https://github.com/rubycas/rubycas-client#defining-a-logout-action
  def logout
    @cas_current_user = @extra_attributes = nil
    reset_session
    CASClient::Frameworks::Rails::Filter.logout(self, root_url)
  end

end
