module Resque
  module Plugins
    module Statsd

      def after_enqueue_statsd(*args)
        StatsdHelper.statsd.increment("resque.#{@queue}.enqueued")
        StatsdHelper.statsd.increment("resque.total.enqueued")
      end

      def after_perform_statsd(*args)
        StatsdHelper.statsd.increment("resque.#{@queue}.finished")
        StatsdHelper.statsd.increment("resque.total.finished")
      end

      def on_failure_statsd(*args)
        StatsdHelper.statsd.increment("resque.#{@queue}.failed")
        StatsdHelper.statsd.increment("resque.total.failed")
      end

      def around_perform_statsd(*args)
        StatsdHelper.statsd.time("resque.#{@queue}.processed") do
          yield
        end
      end
    end
  end
end


