$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'bundler'

require 'rake'
require 'rake/testtask'

require 'rake/gempackagetask'

gemspec = eval File.read('gsolr.gemspec')

# Gem packaging tasks
Rake::GemPackageTask.new(gemspec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
end

task :gem => :gemspec

desc %{Build the gemspec file.}
task :gemspec do
  gemspec.validate
end

desc %{Release the gem to RubyGems.org}
task :release => :gem do
  system "gem push pkg/#{gemspec.name}-#{gemspec.version}.gem"
end


ENV['RUBYOPT'] = '-W1'
 
task :environment do
  require File.dirname(__FILE__) + '/lib/gsolr'
end
 
Dir['tasks/**/*.rake'].each { |t| load t }

task :default => ['spec:api']