module DashboardsHelper

  def fetch_upcoming_challenges
    Challenge.upcoming(Time.now)
  end

end
