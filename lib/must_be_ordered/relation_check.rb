module MustBeOrdered
  class OrderNotApplied < StandardError; end

  module RelationCheck

    private

    def exec_queries(&block)
      if klass.__must_be_ordered__? && order_values.empty?
        UniformNotifier.active_notifiers.each do |notifier|
          notifier.out_of_channel_notify('order not applied')
        end
      end
      super
    end
  end
end

ActiveRecord::Relation.prepend MustBeOrdered::RelationCheck
