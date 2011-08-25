module Resque
  module Plugins
    module Statsd

      def after_enqueue_statsd(*args)
        StatsdHelper.statsd.increment("#{@queue}.enqueued")
        StatsdHelper.statsd.increment("total.enqueued")
      end

      def after_perform_statsd(*args)
        StatsdHelper.statsd.increment("#{@queue}.finished")
        StatsdHelper.statsd.increment("total.finished")
      end

      def on_failure_statsd(*args)
        StatsdHelper.statsd.increment("#{@queue}.failed")
        StatsdHelper.statsd.increment("total.failed")
      end

      def around_perform_statsd(*args)
        StatsdHelper.statsd.time("#{@queue}.processed") do
          yield
        end
      end
    end
  end
end


