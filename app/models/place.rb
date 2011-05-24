class Place < ActiveRecord::Base
	validates_presence_of :name
	validates_presence_of :long
	validates_presence_of :lat
	
	before_create :autostatus
	
	def autostatus
		self.status = "Pending"
	end
end
