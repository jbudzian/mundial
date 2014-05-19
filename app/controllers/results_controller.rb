class ResultsController < ApplicationController

  include AuthHelper
  before_filter :ensure_signed_in_user
  before_filter :ensure_admin_user

  def new
    logger.debug "ResultsController.new params: #{params}"
    @match = Match.find(params[:match_id])
    @result = Result.new
    @result.match = @match
  end

  def create
    logger.debug "ResultsController.create params: #{params}"
    @match = Match.find(params[:result][:match_id])
    @result = Result.new
    # assign foreign keys
    @result.match = @match
    # remove match from params
    params[:result].delete :match_id

    @result.update_attributes(params[:result])
    if @result.save
      flash[:success] = "The result was saved"
      redirect_to matches_path
    else
      render 'new'
    end
  end
  
  def edit
    @result = Result.find(params[:id])
    @match = @result.match
  end

  def update
    @result = Result.find(params[:id])
    @match = @result.match
    @result.update_attributes(params[:result])
    if @result.save
      flash[:success] = "The changes to result were saved"
      redirect_to matches_path
    else
      render 'edit'
    end
  end
  
end
