module Resque
  module Plugins
    module Statsd
      
      def after_enqueue_statsd(*args)
        $statsd.increment("#{@queue}.enqueued")
        $statsd.increment("total.enqueued")
        
      end
      
      def after_perform_statsd(*args)
        $statsd.increment("#{@queue}.finished")
        $statsd.increment("total.finished")
      end
      
      def on_failure_statsd(*args)
        $statsd.increment("#{@queue}.failed")
        $statsd.increment("total.failed")
      end
      
      def around_perform_statsd(*args)
        $statsd.time("#{@queue}.processed") do 
          yield
        end
      end

    end
  end
end
