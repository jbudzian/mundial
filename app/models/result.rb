class Result < ActiveRecord::Base
  attr_accessible :home_team_goals_90mins, :away_team_goals_90mins, :result_full_time
  
  belongs_to :match

  validates :away_team_goals_90mins, :numericality => {:only_integer => true}
  validates :home_team_goals_90mins, :numericality => {:only_integer => true}
  validates :result_full_time, :numericality => {:only_integer => true}
  
  validate :result_cannot_be_set_before_match_start

  def result_90mins_string
    {ApplicationHelper::DRAW => "Draw",
      ApplicationHelper::HOME_TEAM_WIN => match.home_team.name,
      ApplicationHelper::AWAY_TEAM_WIN => match.away_team.name}[result_90mins]
  end
  
  def result_90mins
    if home_team_goals_90mins < away_team_goals_90mins
      ApplicationHelper::AWAY_TEAM_WIN
    elsif home_team_goals_90mins > away_team_goals_90mins
      ApplicationHelper::HOME_TEAM_WIN
    else
      ApplicationHelper::DRAW
    end
  end
  
  def home_team_eliminated
    result_full_time == ApplicationHelper::AWAY_TEAM_WIN
  end
  
  def team_to_advance_string
    if match.is_playoff
      raise "unexpected DRAW in a playoff game!!!" if match.result.result_full_time == ApplicationHelper::DRAW
      match.result.result_full_time
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
