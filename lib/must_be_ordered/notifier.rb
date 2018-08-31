module MustBeOrdered
  module Notifier
    module_function

    def exception_class=(should_raise)
      @exception_class = (should_raise ? MustBeOrdered::OrderNotApplied : nil)
    end

    def customized_logger=(active)
      return unless active
      require 'fileutils'
      require 'logger'
      root_path = (defined?(::Rails) ? Rails.root.to_s : Dir.pwd).to_s
      FileUtils.mkdir_p(root_path + '/log')
      must_be_ordered_log_file = File.open("#{root_path}/log/must_be_ordered.log", 'a+')
      must_be_ordered_log_file.sync = true
      @customized_logger = Logger.new(must_be_ordered_log_file)
      def @customized_logger.format_message(severity, timestamp, _progname, msg)
        "#{timestamp.strftime('%Y-%m-%d %H:%M:%S')}[#{severity}] #{msg}"
      end
    end

    def rails_logger=(active)
      @rails_logger = active
    end

    def notify(message)
      @customized_logger.warn(message) if @customized_logger
      Rails.logger.warn(message) if @rails_logger
      raise @exception_class, message if @exception_class
    end
  end
end
