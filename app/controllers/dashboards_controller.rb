class DashboardsController < ApplicationController
	def index
		month = params[:month] || Time.now.month
		year = params[:year] || Time.now.year
		@date = DateTime.new(year,month)
		@data = User.dashboard_data(month,year)
	end	
end
