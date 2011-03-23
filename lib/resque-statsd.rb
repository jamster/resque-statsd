require 'rubygems'
require 'statsd' # Really Jnunemakers's mine branch of statsd 
$statsd = Statsd.new('graphite.beenverified.com', 8125)
$statsd.namespace="beenverified_#{ENV['RAILS_ENV']}.resque"

module Resque
  module Plugins
    module Loner
      VERSION = "0.0.1"
    end
  end
end

