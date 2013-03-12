class BaseballController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:index, :show, :search]

  def index
    @free_agents = BaseballProjection.where(batter: params[:b] == 'false' ? false : true).order_by(:rank.asc)

    if user_signed_in?
      @team = params[:id] ? BaseballTeam.find(params[:id]) : current_user.baseball_teams.last
      # @team.catchers << BaseballProjection.all.sample
      # @free_agents = @free_agents.not_in(@team.baseball_projection_ids)

      @batting_roster = {"catchers" => "C", "first_basemen" => "1B", "second_basemen" => "2B", "shortstops" => "SS", "third_basemen" => "3B",
        "outfielders" => "OF", "utility_men" => "UTIL", "middle_infielders" => "MI", "corner_infielders" => "CI"}
      @pitching_roster = {"starting_pitchers" => "SP", "relief_pitchers" => "RP", "pitchers" => "P", "bench" => "BENCH"}
    else
      @user = User.new
      @user.baseball_teams.build
    end
  end

  def show
  	@player = BaseballProjection.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def search
    @search = BaseballProjection.where(name: /#{params[:query]}/i)
  	@results = @search.blank? || params[:query].blank? ? BaseballProjection.where(batter: true).order_by(:rank.asc) : @search
    # @league_type = params[:league_type]

    # if current_user.try(:baseball_team)
    #   drafted_ids = current_user.baseball_team.baseball_projection_ids.present? ? current_user.baseball_team.baseball_projection_ids : []
    #   removed_ids = current_user.baseball_team.removed.present? ? current_user.baseball_team.removed : []
    #   @projections = @projections.not_in(id: drafted_ids + removed_ids)
    # end
  end
end
