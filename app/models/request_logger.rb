class RequestLogger < ActiveRecord::Base
	def update_record
		existing_entry = RequestLogger.find_by(
							:ip => self.ip, 
							:path => self.path, 
							:url => self.url, 
							:user_agent => self.user_agent,
							:method => self.method,
							:post_data => self.post_data)

		if existing_entry == nil
			self.save
		else		
			existing_entry.count += 1
			existing_entry.save
		end
	end
end
