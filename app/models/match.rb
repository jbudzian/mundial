class Match < ActiveRecord::Base
  attr_accessible :match_date, :match_no, :tournament_stage, :venue, :is_playoff
  
  belongs_to :home_team, class_name: "Team", foreign_key: "home_team_id"
  belongs_to :away_team, class_name: "Team", foreign_key: "away_team_id"
  has_many :bets
  has_one :result
  
  validates :match_no, :numericality => {:only_integer => true}
  validates :match_date, :match_no, :tournament_stage, :venue, presence: true
  validates_inclusion_of :is_playoff, :in => [true, false]
  
  # returns appropriate CSS style for home team result
  def home_team_result
    if self.result.nil?
      ''
    else
      if self.result.result_full_time == ApplicationHelper::HOME_TEAM_WIN
        'home_team_win'
      elsif self.result.result_full_time == ApplicationHelper::DRAW
        'home_team_draw'
      else
        ''
      end
    end
  end
  
  # returns appropriate CSS style for away team result
  def away_team_result
    if self.result.nil?
      ''
    else
      if self.result.result_full_time == ApplicationHelper::AWAY_TEAM_WIN
        'away_team_win'
      elsif self.result.result_full_time == ApplicationHelper::DRAW
        'away_team_draw'
      else
        ''
      end
    end
  end

  def user_has_bet? user
    bets.where(:user_id => user.id).count > 0
  end
  
end
