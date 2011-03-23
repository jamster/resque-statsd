module Resque
  module Plugins
    module Statsd

      def after_enqueue_statsd(*args)
        $resque_statsd.increment("#{@queue}.enqueued")
        $resque_statsd.increment("total.enqueued")
        
      end
      
      def after_perform_statsd(*args)
        $resque_statsd.increment("#{@queue}.finished")
        $resque_statsd.increment("total.finished")
      end
      
      def on_failure_statsd(*args)
        $resque_statsd.increment("#{@queue}.failed")
        $resque_statsd.increment("total.failed")
      end
      
      def around_perform_statsd(*args)
        $resque_statsd.time("#{@queue}.processed") do 
          yield
        end
      end

    end
  end
end


