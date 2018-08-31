module MustBeOrdered
  module StackTraceFilter
    VENDOR_PATH = '/vendor'

    def caller_in_project
      app_root = defined?(::Rails) ? Rails.root.to_s : Dir.pwd
      vendor_root = app_root + VENDOR_PATH
      bundler_path = Bundler.bundle_path.to_s
      select_caller_locations do |location|
        caller_path = location_as_path(location)
        caller_path.include?(app_root) && !caller_path.include?(vendor_root) && !caller_path.include?(bundler_path)
      end
    end

    private

    def pattern_matches?(location, pattern)
      path = location_as_path(location)
      case pattern
      when Array
        pattern_path = pattern.first
        filter = pattern.last
        return false unless pattern_matches?(location, pattern_path)

        case filter
        when Range
          filter.include?(location.lineno)
        when Integer
          filter == location.lineno
        when String
          filter == location.base_label
        end
      when String
        path.include?(pattern)
      when Regexp
        path =~ pattern
      end
    end

    def location_as_path(location)
      ruby_19? ? location : location.absolute_path.to_s
    end

    def select_caller_locations
      if ruby_19?
        caller.select do |caller_path|
          yield caller_path
        end
      else
        caller_locations.select do |location|
          yield location
        end
      end
    end

    def ruby_19?
      if @ruby_19.nil?
        @ruby_19 = Gem::Version.new(RUBY_VERSION) < Gem::Version.new('2.0.0')
      end
      @ruby_19
    end
  end
end
