class TeamsController < ApplicationController
  def index
    @teams = Team.select { |team| !team.placeholder }
  end
end
