module ApplicationHelper
	def batters?
		params[:b].blank? || params[:b] == 'true'
	end
	def pitchers?
		params[:b] == 'false'
	end
end
