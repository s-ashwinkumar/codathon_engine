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

  def get_home_path
    "#{current_user.class.to_s.downcase}_home_path"
  end

  def get_greetings
    current_time = Time.now.to_i
    midnight = Time.now.beginning_of_day.to_i
    noon = (midnight+12.hours).to_i
    five_pm = (noon+5.hours).to_i
    eight_pm = (five_pm+3.hours).to_i

    case
    when midnight.upto(noon).include?(current_time)
      message = "Good Morning !"
    when noon.upto(five_pm).include?(current_time)
      message = "Good Afternoon !"
    when five_pm.upto(eight_pm).include?(current_time)
      message = "Good Evening !"
    when eight_pm.upto(midnight + 1.day).include?(current_time)
      message = "Good Night !"
    end
    message
  end
end
