# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Codathon::Application.initialize!

#Docs : https://github.com/rubycas/rubycas-client#using-rubycas-client-in-rails-controllers
CASClient::Frameworks::Rails::Filter.configure(
  :cas_base_url => "http://cas.lister.net/"
)