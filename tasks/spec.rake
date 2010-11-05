# gem 'rspec'

# $stderr.puts `gem list`

require 'rspec'
require 'rspec/core'
require 'rspec/core/rake_task'

namespace :spec do
  namespace :ruby do
    desc 'run api specs through the Ruby implementations'
    task :api do
      puts "Ruby 1.8.7"
      puts `rake spec:api`
      puts "Ruby 1.9"
      puts `rake1.9 spec:api`
      puts "JRuby"
      puts `jruby -S rake spec:api`
    end
  end

  desc 'run api specs (mock out Solr dependency)'
  Rspec::Core::RakeTask.new(:api) do |spec|
    spec.pattern    = "spec/api/**/*_spec.rb"
    spec.verbose    = true
    spec.rspec_opts = ['--color']
  end

  desc 'run integration specs'
  Rspec::Core::RakeTask.new(:integration) do |spec|
    spec.pattern    = "spec/integration/**/*_spec.rb"
    spec.verbose    = true
    spec.rspec_opts = ['--color']
  end
end
