module ApplicationHelper
 
 def is_active?(link_path)
  current_page?(link_path) ? "active" : ""
 end

 def username(session)
 	session[:cas_extra_attributes]["cn"][0].split[0]
 end	

end
