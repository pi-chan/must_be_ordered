require "active_record"

require "must_be_ordered/version"
require "must_be_ordered/relation_check"

module MustBeOrdered
  class << self
    def enabled=(value)
      @enabled = value
    end

    def enabled?
      !!@enabled
    end
  end

  def self.extended(klass)
    klass.class_eval do
      class_attribute :__must_be_ordered__
    end
  end

  def must_be_ordered
    self.__must_be_ordered__ = true
  end
end

ActiveRecord::Base.extend MustBeOrdered
