class HomeController < ApplicationController
	def index
		@pages = get_next_pages 10

		@page_title = params[:page].capitalize if params[:page] != nil
		@page_title += ' - ' +  params[:page2].capitalize if params[:page2] != nil
		@page_title += ' - ' + params[:page3].capitalize if params[:page3] != nil
		@page_title = "Index" if @page_title == nil
	end

	private
		def get_next_pages num
			nouns = load_nouns
			pages = Array.new
			rand = Random.new

			num.times do
				page = ''
				rand(1..3).times do 
					page += '/' + nouns[rand(nouns.length)]
				end
				pages << page
			end
			return pages
		end

		def load_nouns
			nouns = Array.new

			puts "Have #{nouns.length} pages in memory."
			#do magic thing and fetch from memory instead of disc.
			
			puts "Loading nouns from ../assets/nouns.txt"
			File.open(Rails.root.to_s + '/app/assets/nouns.txt', 'r') do |infile|
				while (line = infile.gets)
					nouns << line.gsub("\n", "") unless line.length == 0
				end
			end
			puts "Loaded #{nouns.length} nouns."
			return nouns
		end
end
