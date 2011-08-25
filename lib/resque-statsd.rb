require 'rubygems'
require 'statsd' # Really Jnunemakers's mine branch of statsd 
require 'resque/plugins/statsd'

module Resque
  module Plugins
    module Statsd
      VERSION = "0.0.2"

      def self.graphite_host
        return @@graphite_host || ENV['GRAPHITE_HOST'] || 'localhost'
      end
      def self.graphite_host=(val)
        @@graphite_host = val
      end

      def self.graphite_port
        return @@graphite_port || ENV['GRAPHITE_PORT'] || 8125
      end
      def self.graphite_port=(val)
        @@graphite_port = val
      end

      def self.namespace
        return @@namespace || ENV['GRAPHITE_NAMESPACE'] || 'resque'
      end
      def self.namespace=(val)
        @@namespace = val
      end

      # Set up the client lazily, to minimize order-of-operations headaches.
      def self.statsd
        if(@@stats.nil?)
          @@statsd = Statsd.new(graphite_host, graphite_port)
          @@statsd.namespace = namespace
        end
        return @@statsd
      end
    end
  end
end
