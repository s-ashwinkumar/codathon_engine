class DashboardsController < ApplicationController
	def index
		month = (params[:month] || Time.now.month).to_i
		year = (params[:year] || Time.now.year).to_i

		@date = DateTime.new(year,month)
		@data = User.dashboard_data(month,year).paginate(:page => params[:page], :per_page => 1)
		
		if request.xhr?
			render :partial => "dashboard_data", :locals => { data: @data}
		end	
	end	
end
