Gem::Specification.new do |s|
 s.name        = 'resque-statsd'
 s.version     = '0.0.2'
 s.homepage    = 'http://github.com/jamster/resque-statsd'
 s.license     = 'MIT'
 s.summary     = 'Adds simple counters and timers for statsd into your Resque jobs'
 s.description = "Will add a counter for enqueuing, performing, failing and timing Jobs"
 s.email       = "jayamster@gmail.com"
 s.authors     = ["Jason Amster"]
 s.files       = ["lib/resque-statsd.rb", "lib/resque/plugins/statsd.rb"]
end

