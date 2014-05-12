class Match < ActiveRecord::Base
  attr_accessible :match_date, :match_no, :tournament_stage, :venue
  
  belongs_to :home_team, class_name: "Team", foreign_key: "home_team_id"
  belongs_to :away_team, class_name: "Team", foreign_key: "away_team_id"
  
  validates :match_no, :numericality => {:only_integer => true}
end
