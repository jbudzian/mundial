class BetsController < ApplicationController
  include AuthHelper
  before_filter :ensure_signed_in_user, only: [:new, :edit, :update]
  
  def new
    logger.debug "BetsController.new params: #{params}"
    @bet = Bet.new
    @bet.match = Match.find(params[:match_id])
    @bet.user = current_user
  end

  def create
    logger.debug "BetsController.create params: #{params}"
    @bet = Bet.new
    # assign foreign keys
    @bet.match = Match.find(params[:bet][:match_id])
    @bet.user = current_user
    # remove match from params
    params[:bet].delete :match_id
    #params[:match].delete :away_team_id
    @bet.update_attributes(params[:bet])
    if @bet.save
      flash[:success] = "The bet was saved"
      redirect_to matches_path
    else
      render 'new'
    end
  end
  
  def edit
    # assuming that provided id is for MATCH - NOT BET!!!
    @bet = Bet.where(:match_id => params[:id], :user_id => current_user.id).first
    if @bet == nil
      redirect_to new_bet_path(:match_id => params[:id])
    end
      
  end

  def update
    logger.debug "BetsController.update params: #{params}"
    @bet = Bet.where(:match_id => params[:bet][:match_id], :user_id => current_user.id).first
    # remove match from params
    params[:bet].delete :match_id
    #params[:match].delete :away_team_id
    @bet.update_attributes(params[:bet])
    if @bet.save
      flash[:success] = "The bet was saved"
      redirect_to matches_path
    else
      render 'edit'
    end
  end
  
end
