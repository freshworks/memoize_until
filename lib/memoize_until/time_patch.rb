# frozen_string_literal: true

unless Time.instance_methods.include?(:week)
  class MemoizeUntil
    module TimePatch
      # returns number representing the nth week of the month
      def week
        day / 7
      end
    end
  end
  Time.prepend MemoizeUntil::TimePatch
end
