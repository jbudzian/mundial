class Bet < ActiveRecord::Base
  attr_accessible :away_team_goals_90mins, :home_team_eliminated, :home_team_goals_90mins, :result_90mins
  
  belongs_to :match, class_name: "Match", foreign_key: "match_id"
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  
  validates :away_team_goals_90mins, :numericality => {:only_integer => true}
  validates :home_team_goals_90mins, :numericality => {:only_integer => true}
  validates :result_90mins, :numericality => {:only_integer => true}
end