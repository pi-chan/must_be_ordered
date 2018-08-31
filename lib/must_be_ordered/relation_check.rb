module MustBeOrdered
  class OrderNotApplied < StandardError; end

  module RelationCheck
    include StackTraceFilter

    private

    def exec_queries(&block)
      return super unless MustBeOrdered.enabled?

      if klass.__must_be_ordered__? && order_values.empty?
        trace = caller_in_project.join("\n")
        Notifier.notify("MustBeOrdered order not applied #{klass.to_s}:\n#{trace}")
      end
      super
    end
  end
end

ActiveRecord::Relation.prepend MustBeOrdered::RelationCheck
