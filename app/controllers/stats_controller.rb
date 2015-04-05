class StatsController < ApplicationController
	def index
		@stats = Hash.new
		@stats[:raw] = RequestLogger.all
		@stats[:unique_ips] = @stats[:raw].group(:ip).count.length
		@stats[:unique_uas] = @stats[:raw].group(:user_agent).count.length
		@stats[:total_served] = @stats[:raw].sum(:count)
		@stats[:request_types] = @stats[:raw].group(:method).sum(:count)
		
	end
end
