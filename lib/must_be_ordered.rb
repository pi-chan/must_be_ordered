require "active_record"

require "must_be_ordered/version"
require "must_be_ordered/notifier"
require "must_be_ordered/stack_trace_filter"
require "must_be_ordered/relation_check"

module MustBeOrdered
  class << self
    def enabled=(value)
      @enabled = value
    end

    def enabled?
      !!@enabled
    end

    def raise=(should_raise)
      Notifier.exception_class = (should_raise ? MustBeOrdered::OrderNotApplied : nil)
    end

    def rails_logger=(active)
      Notifier.rails_logger = active
    end

    def must_be_ordered_logger=(active)
      Notifier.customized_logger = active
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
