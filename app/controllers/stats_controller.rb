class StatsController < ApplicationController
	require 'base64'	
	def index
		@stats = Hash.new
		@stats[:raw] = RequestLogger.all
		@stats[:unique_ips] = @stats[:raw].group(:ip).count.length
		@stats[:unique_uas] = @stats[:raw].group(:user_agent).count.length
		@stats[:total_served] = @stats[:raw].sum(:count)
		@stats[:request_types] = @stats[:raw].group(:method).sum(:count).sort_by do |method, count| count end.reverse
	end

	def ip_list
		@ips = RequestLogger.all.group(:ip).count.sort_by do |ip, count| count end.reverse
	end

	def ua_list
		@uas = RequestLogger.all.group(:user_agent).count.sort_by do |ua, count| count end.reverse
		@uas.each do |ua|
			ua[0] = "nil" if ua[0] == nil
			ua.push(Base64.encode64(ua[0]))
		end
	end

	def top_pages
		@top = RequestLogger.all.group(:path).count.sort_by do |path, count| count end.reverse
	end
	
	def ua_stats
		ua = Base64.decode64(params[:ua])
		ua = nil if ua == "nil"
		entries = RequestLogger.all.where(:user_agent => ua)
		@ips = entries.group(:ip).count.sort_by do |ip, count| count end.reverse
		@pages = entries.group(:path).count.sort_by do |path, count| count end.reverse
	end

	def ip_stats
		ip = params[:ip].to_s.gsub("_", "\.")
		entries = RequestLogger.all.where(:ip => ip)
		@uas = entries.group(:user_agent).count.sort_by do |ua, count| count end.reverse
		@pages = entries.group(:path).count.sort_by do |path, count| count end.reverse
	
		@uas.each do |ua|
			ua[0] = "nil" if ua[0] == nil
			ua.push(Base64.encode64(ua[0]))
		end

	end
end
