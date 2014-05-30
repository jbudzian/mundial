class Result < ActiveRecord::Base
  attr_accessible :home_team_goals_90mins, :away_team_goals_90mins, :result_full_time
  
  belongs_to :match

  validates :away_team_goals_90mins, :numericality => {:only_integer => true}
  validates :home_team_goals_90mins, :numericality => {:only_integer => true}
  validates :result_full_time, :numericality => {:only_integer => true}
  
  validate :result_cannot_be_set_before_match_start

  def result_90mins_string
    if home_team_goals_90mins < away_team_goals_90mins
      match.away_team.name
    elsif home_team_goals_90mins > away_team_goals_90mins
      match.home_team.name
    else
      "Draw"
    end
  end
  
  def team_to_advance_string
    if match.is_playoff
      raise "unexpected DRAW in a playoff game!!!" if match.result_full_time == ApplicationHelper::DRAW
      match.result_full_time
    else
      'n/a'
    end
  end
    
  private
  
  def result_cannot_be_set_before_match_start
    if match.match_date > Time.now
      errors[:base] << "This result cannot be saved because the match has not started!"
    end
  end
end
