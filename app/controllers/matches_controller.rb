class MatchesController < ApplicationController
  include AuthHelper
  
  before_filter :ensure_signed_in_user, only: [:index, :edit, :update]
  before_filter :ensure_admin_user, only: [:edit, :update]
  
  def index
    @matches = Match.all.sort_by{ |m| m.match_no }
  end
  
  def edit
    @match = Match.find(params[:id])
  end
  
  def update
    @match = Match.find(params[:id])
    # assign teams
    @match.home_team = Team.find(params[:match][:home_team_id])
    @match.away_team = Team.find(params[:match][:away_team_id])
    # remove assignment from params
    params[:match].delete :home_team_id
    params[:match].delete :away_team_id
    # mass-assign remaining attributes    
    if @match.update_attributes(params[:match])
      flash[:success] = "Match updated"
      redirect_to matches_path
    else
      render 'edit'
    end
  end

end
