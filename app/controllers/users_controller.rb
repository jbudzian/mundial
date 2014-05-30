class UsersController < ApplicationController
  include AuthHelper
  
  before_filter :ensure_signed_in_user, only: [:index, :edit, :update]
  before_filter :ensure_correct_user, only: [:edit, :update]
  
  def index
    allUsers = User.all.sort_by {|usr| -usr.current_score}
    lastIndex = 0
    lastScore = -1
    allUsers.each do |usr|
      if usr.current_score == lastScore
        usr.current_place = '-'
      else
        lastScore = usr.current_score
        lastIndex += 1
        if lastIndex == 100
          usr.current_place = "\u2460"
        else
          usr.current_place = "#{lastIndex}"
        end
      end
    end
    @users = allUsers
  end
  
  def show
    @user = User.find(params[:id])
    @bets = @user.bets.sort_by{ |b| b.match.match_no }
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Mundial Tournament!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def ensure_correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
