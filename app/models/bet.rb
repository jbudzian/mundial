class Bet < ActiveRecord::Base
  attr_accessible :away_team_goals_90mins, :home_team_eliminated, :home_team_goals_90mins, :result_90mins
  
  belongs_to :match
  belongs_to :user
  
  validates :away_team_goals_90mins, :numericality => {:only_integer => true}
  validates :home_team_goals_90mins, :numericality => {:only_integer => true}
  validates :result_90mins, :numericality => {:only_integer => true, :message => "cannot be blank"}
  validates :home_team_eliminated, :inclusion => {:in => [true, false], :message => "cannot be blank"}

  validate :bet_cannot_be_saved_after_match_start
  
  def points_awarded
    if match.result.nil?
      nil
    else
      points = 0
      points += 1 if home_team_goals_90mins == match.result.home_team_goals_90mins and away_team_goals_90mins == match.result.away_team_goals_90mins
      if match.is_playoff
        points += 1 if result_90mins == match.result.result_90mins
      else
        points += 1 if result_90mins == match.result.result_full_time
      end
      points += 1 if match.is_playoff and home_team_eliminated == match.result.home_team_eliminated
      points   
    end
  end
  
  def result_90mins_string
    {ApplicationHelper::DRAW => "Draw",
      ApplicationHelper::HOME_TEAM_WIN => match.home_team.name,
      ApplicationHelper::AWAY_TEAM_WIN => match.away_team.name}[result_90mins]
  end
  
  private
  
  def bet_cannot_be_saved_after_match_start
    if match.match_date < Time.now
      errors[:base] << "This bet cannot be saved because the match has started in the past!"
    end
  end
end
