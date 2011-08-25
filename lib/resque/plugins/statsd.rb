module Resque
  module Plugins
    module Statsd

      def after_enqueue_statsd(*args)
        self.statsd.increment("#{@queue}.enqueued")
        self.statsd.increment("total.enqueued")
      end

      def after_perform_statsd(*args)
        self.statsd.increment("#{@queue}.finished")
        self.statsd.increment("total.finished")
      end

      def on_failure_statsd(*args)
        self.statsd.increment("#{@queue}.failed")
        self.statsd.increment("total.failed")
      end

      def around_perform_statsd(*args)
        self.statsd.time("#{@queue}.processed") do
          yield
        end
      end
    end
  end
end


