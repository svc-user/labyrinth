class StatsController < ApplicationController
	def index
		@stats = Hash.new
		@stats[:raw] = RequestLogger.all
		@stats[:unique_ips] = @stats[:raw].group(:ip).count.length
		@stats[:unique_uas] = @stats[:raw].group(:user_agent).count.length
		@stats[:total_served] = @stats[:raw].sum(:count)
		@stats[:request_types] = @stats[:raw].group(:method).sum(:count)
	end

	def ip_list
		@ips = RequestLogger.all.group(:ip).count.sort_by do |ip, count| count end.reverse
	end

	def ua_list
		@uas = RequestLogger.all.group(:user_agent).count.sort_by do |ua, count| count end.reverse
	end

	def top_pages
		@top = RequestLogger.all.group(:path).count.sort_by do |path, count| count end.reverse
	end

end
