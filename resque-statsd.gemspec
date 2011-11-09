Gem::Specification.new do |s|
  s.name = 'resque-statsd'
  s.version = '0.0.1'
  s.author = 'Jason Amster'
  s.email = 'jayamster@gmail.com'
  s.summary = 'Resque Statsd is a Resque plugin that will collect and send data samples from your Resque Jobs to statsd'

  s.add_dependency('statsd-ruby', '~>0.3.0')
  s.files = Dir['lib/**/*']
  s.require_path = 'lib'
end

