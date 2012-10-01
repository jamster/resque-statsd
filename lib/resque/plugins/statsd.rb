module Resque
  module Plugins
    module Statsd
      @@resque_statsd = nil

      def self.statsd_client
        if @@resque_statsd.nil?
          # Set up the client once
          require 'statsd'
          @@resque_statsd = Statsd.new(ENV['GRAPHITE_HOST'], 8125)
          @@resque_statsd.namespace="#{ENV['APP_NAME']}_#{ENV['RAILS_ENV']}.resque"
        end
        return @@resque_statsd
      end

      def after_enqueue_statsd(*args)
        self.statsd_client.increment("#{@queue}.enqueued")
        self.statsd_client.increment("total.enqueued")
      end
      
      def after_perform_statsd(*args)
        self.statsd_client.increment("#{@queue}.finished")
        self.statsd_client.increment("total.finished")
      end
      
      def on_failure_statsd(*args)
        self.statsd_client.increment("#{@queue}.failed")
        self.statsd_client.increment("total.failed")
      end

      def around_perform_statsd(*args)
        self.statsd_client.time("#{@queue}.processed") do
          yield
        end
      end

      def self.increment_metric(metric)
        # Automatically appends queue name to the parameter
        # before incrementing
        self.statsd_client.increment("#{@queue}.#{metric}")
      end
    end
  end
end


