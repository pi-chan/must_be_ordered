require "active_record"
require 'uniform_notifier'

require "must_be_ordered/version"
require "must_be_ordered/stack_trace_filter"
require "must_be_ordered/relation_check"

module MustBeOrdered
  class << self
    available_notifiers = UniformNotifier::AVAILABLE_NOTIFIERS.map { |notifier| "#{notifier}=" }
    available_notifiers << { to: UniformNotifier }
    delegate(*available_notifiers)

    def enabled=(value)
      @enabled = value
    end

    def enabled?
      !!@enabled
    end

    def raise=(should_raise)
      UniformNotifier.raise = (should_raise ? MustBeOrdered::OrderNotApplied : false)
    end

    def must_be_ordered_logger=(active)
      if active
        require 'fileutils'
        root_path = (defined?(::Rails) ? Rails.root.to_s : Dir.pwd).to_s
        FileUtils.mkdir_p(root_path + '/log')
        must_be_ordered_log_file = File.open("#{root_path}/log/must_be_ordered.log", 'a+')
        must_be_ordered_log_file.sync = true
        UniformNotifier.customized_logger = must_be_ordered_log_file
      end
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
