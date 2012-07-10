require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "resque-statsd"
  gem.homepage = "http://github.com/cloudability/resque-statsd"
  gem.license = "MIT"
  gem.summary = %Q{Adds simple counters and timers for statsd into your Resque jobs}
  gem.description = %Q{Will add a counter for enqueuing, performing, failing and timing Jobs}
  gem.email = "engineering@cloudability.com"
  gem.authors = ["Jon Frisby", "Jason Amster"]
  gem.require_path = 'lib'

  gem.files.reject! do |fn|
    fn =~ /^\.(rvmrc|rspec|document|gitignore)$/ ||
    fn =~ /^VERSION$/ ||
    fn =~ /^(spec|features)\//
  end
end
Jeweler::RubygemsDotOrgTasks.new

# require 'rspec/core'
# require 'rspec/core/rake_task'
# RSpec::Core::RakeTask.new(:spec) do |spec|
#   spec.pattern = FileList['spec/**/*_spec.rb']
# end
#
# RSpec::Core::RakeTask.new(:rcov) do |spec|
#   spec.pattern = 'spec/**/*_spec.rb'
#   spec.rcov = true
# end
#
# task :default => :spec

# require 'yard'
# YARD::Rake::YardocTask.new
