unless Time.instance_methods.include?(:week)
	module MemoizeUntil::TimePatch
    # returns number representing the nth week of the month
    def week
        self.day / 7
    end
	end
	Time.prepend MemoizeUntil::TimePatch
end