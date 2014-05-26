class Result < ActiveRecord::Base
  attr_accessible :home_team_goals_90mins, :away_team_goals_90mins, :result_full_time
  
  belongs_to :match

  validates :away_team_goals_90mins, :numericality => {:only_integer => true}
  validates :home_team_goals_90mins, :numericality => {:only_integer => true}
  validates :result_full_time, :numericality => {:only_integer => true}
  
  validate :result_cannot_be_set_before_match_start
  
  private
  
  def result_cannot_be_set_before_match_start
    if match.match_date > Time.now
      errors[:base] << "This result cannot be saved because the match has not started!"
    end
  end
end
