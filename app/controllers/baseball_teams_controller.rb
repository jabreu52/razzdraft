class BaseballTeamsController < ApplicationController
	def new
		@baseball_team = BaseballTeam.new
	end
	def create
		@baseball_team = BaseballTeam.new(params[:baseball_team])
		@baseball_team.user = current_user

		if @baseball_team.save
			redirect_to root_path, notice: "Success!!!"
		end
	end
	def show
		@team = BaseballTeam.find(params[:id])
	end
end
