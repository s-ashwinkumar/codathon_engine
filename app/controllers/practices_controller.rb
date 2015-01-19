class PracticesController < ApplicationController
	layout "participant"
	def index
		@submissions ||= []
	end
end
