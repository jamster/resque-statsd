module Resque
  module Plugins
    module Statsd
      def after_enqueue_statsd(*args)
        StatsdHelper.statsd.increment("queues.#{@queue}.enqueued")
        StatsdHelper.statsd.increment("jobs.#{self.name}.enqueued")
        StatsdHelper.statsd.increment("total.enqueued")
      end

      def before_perform_statsd(*args)
        StatsdHelper.statsd.increment("queues.#{@queue}.started")
        StatsdHelper.statsd.increment("jobs.#{self.name}.started")
        StatsdHelper.statsd.increment("total.started")
      end

      def after_perform_statsd(*args)
        StatsdHelper.statsd.increment("queues.#{@queue}.finished")
        StatsdHelper.statsd.increment("jobs.#{self.name}.finished")
        StatsdHelper.statsd.increment("total.finished")
      end

      def on_failure_statsd(*args)
        StatsdHelper.statsd.increment("queues.#{@queue}.failed")
        StatsdHelper.statsd.increment("jobs.#{self.name}.failed")
        StatsdHelper.statsd.increment("total.failed")
      end

      def around_perform_statsd(*args)
        StatsdHelper.statsd.time("queues.#{@queue}.processed") do
          StatsdHelper.statsd.time("jobs.#{self.name}.processed") do
            yield
          end
        end
      end
    end
  end
end


