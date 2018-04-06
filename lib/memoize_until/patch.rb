unless Time.instance_methods.include?(:week)
	# returns number representing the nth week of the month
	class Time
		def week
			self.day / 7
		end
	end
end