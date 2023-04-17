# frozen_string_literal: true

class MemoizeUntil
  class NotImplementedError < StandardError; end

  class NullObject
    @null_object ||= NullObject.new

    def self.instance
      @null_object
    end
  end
end
