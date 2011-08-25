require 'rubygems'
require 'statsd' # Really Jnunemakers's mine branch of statsd 
require 'resque/plugins/statsd'

module Resque
  module Plugins
    module Statsd
      VERSION = "0.0.2"

      attr_accessor :graphite_host
      attr_accessor :graphite_port
      attr_accessor :namespace

      # Set up the client lazily, to minimize order-of-operations headaches.
      def self.statsd
        if(@@stats.nil?)
          @@statsd = Statsd.new(graphite_host || 'localhost', graphite_port || 8125)
          @@statsd.namespace = namespace || "resque"
        end
        return @@statsd
      end
    end
  end
end
