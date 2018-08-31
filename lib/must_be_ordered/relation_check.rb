module MustBeOrdered
  class OrderNotApplied < StandardError; end

  module RelationCheck

    private

    def exec_queries(&block)
      return super unless MustBeOrdered.enabled?

      if klass.__must_be_ordered__? && order_values.empty?
        raise MustBeOrdered::OrderNotApplied
      end
      super
    end
  end
end

ActiveRecord::Relation.prepend MustBeOrdered::RelationCheck
