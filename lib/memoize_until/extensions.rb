class MemoizeUntil
	
	class NotImplementedError < StandardError; end
	
	class NullObject
		
		def self.instance
			@@null_object ||= NullObject.new
		end
		
	end
end