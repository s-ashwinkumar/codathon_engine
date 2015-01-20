class PracticesController < ApplicationController
	layout "participant"
	def index
		@submissions = Submission.live_feed
	end
end
