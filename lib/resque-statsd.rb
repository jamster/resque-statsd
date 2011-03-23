require 'rubygems'
require 'statsd' # Really Jnunemakers's mine branch of statsd 
$statsd = Statsd.new(ENV['GRAPHITE_HOST'], 8125)
$statsd.namespace="#{ENV['APP_NAME']}_#{ENV['RAILS_ENV']}.resque"

module Resque
  module Plugins
    module Statsd
      VERSION = "0.0.1"
    end
  end
end

