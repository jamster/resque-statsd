module Resque
  module Plugins
    module Statsd
      
      def after_enqueue_statsd(*args)
        $statsd.increment("#{queue}.enqueued")
      end
      
      def after_perform_statsd(*args)
        $statsd.increment("#{queue}.finished")
      end
      
      def on_failure_statsd(*args)
        $statsd.increment("#{queue}.failed")
      end
      
      def around_perform_statsd(*args)
        $statsd.time("#{queue}.failed") do 
          yield
        end
      end

    end
  end
end
