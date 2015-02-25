class Challenge < ActiveRecord::Base
  attr_accessible :active, :end_date, :start_date, :title

  has_many :questions
  has_many :question_test_cases, through: :questions
  has_many :submissions, through: :question_test_cases, source: :submissions

  accepts_nested_attributes_for :questions
  scope :active, where(:active => true).order('start_date desc')

  def self.currently_running
  	Challenge.active.where("start_date <= NOW() and end_date >= NOW() ").first
  end

  def start_and_end_time_html
  	(start_date.strftime("%b %d, %Y %I:%M %p") + " to " + end_date.strftime("%b %d, %Y %I:%M %p")).html_safe
  end

  def member_engagement
    questions.map{|qs| qs.submissions.collect{|s| s.user_id}}.flatten.uniq.count
  end

  def self.member_engagement(challenge_id = nil)
    engagement = []
    if challenge_id
      ch = find(challenge_id)
      engagement.push([ch.id, ch.member_engagement])
    else
      all.each do |ch|
        engagement.push([ch.id, (ch.questions.map{|qs| qs.submissions.collect{|s| s.user_id}}.flatten.uniq.count)])
      end
    end
    engagement
  end

  def total_points
    questions.collect{|q| q.points}.sum
  end

  def user_scores #{user_id => total_score_for_challenge}
    submissions.sum(:score, :group => :user_id)
  end
end
