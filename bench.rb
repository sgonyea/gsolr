
$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/lib')

require 'rubygems' if RUBY_VERSION < '1.9'
require 'gsolr'
require 'rsolr'
require 'benchmark'

#puts "press any key to continue"; blah = STDIN.gets.chomp

iters = (ARGV[0] || 100).to_i
url   = ARGV[1]
query = ARGV[2] || "hello"

if url.nil? or query.nil?
  puts "to use, call #{$0} with arguments: #iterations solr_url \"query to benchmark\""
  exit
end

Benchmark.bmbm do |x|
  x.report do
    puts "GSolr"
    gsolr = GSolr.connect(:url => url)
    iters.to_i.times do |_i|
      gsolr.request("/select", :q => query)
    end
  end

  x.report do
    puts "RSolr"
    rsolr = RSolr.connect(:url => url)
    iters.to_i.times do
      rsolr.request("/select", :q => query)
    end
  end
end

