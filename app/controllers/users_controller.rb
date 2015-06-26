class UsersController < ApplicationController

  def convert_to_admin
    user = User.find(params[:user_id])
    user.update_attribute("role","Admin")
    render :text => "Converted #{user.full_name} to Admin"
  end
end
