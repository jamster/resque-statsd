module Resque
  module Plugins
    module Statsd

      def after_enqueue_statsd(*args)
        StatsdHelper.statsd.increment("resque.queues.#{@queue}.enqueued")
        StatsdHelper.statsd.increment("resque.jobs.#{self.name}.enqueued")
        StatsdHelper.statsd.increment("resque.total.enqueued")
      end

      def after_perform_statsd(*args)
        StatsdHelper.statsd.increment("resque.queues.#{@queue}.finished")
        StatsdHelper.statsd.increment("resque.jobs.#{self.name}.finished")
        StatsdHelper.statsd.increment("resque.total.finished")
      end

      def on_failure_statsd(*args)
        StatsdHelper.statsd.increment("resque.queues.#{@queue}.failed")
        StatsdHelper.statsd.increment("resque.jobs.#{self.name}.failed")
        StatsdHelper.statsd.increment("resque.total.failed")
      end

      def around_perform_statsd(*args)
        StatsdHelper.statsd.time("resque.queues.#{@queue}.processed") do
          StatsdHelper.statsd.time("resque.jobs.#{self.name}.processed") do
            yield
          end
        end
      end
    end
  end
end


