module ApplicationHelper
 
 def is_active?(link_path)
  current_page?(link_path) ? "active" : ""
 end

 def username(session)
 	session[:cas_extra_attributes]["cn"][0].split[0]
 end

 def current_user
 	User.find_by_user_name(session[:cas_user])
 end

end
