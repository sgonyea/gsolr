$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'bundler'

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'

Bundler::GemHelper.install_tasks

ENV['RUBYOPT'] = '-W1'
 
task :environment do
  require File.dirname(__FILE__) + '/lib/gsolr'
end
 
Dir['tasks/**/*.rake'].each { |t| load t }

task :default => ['spec:api']