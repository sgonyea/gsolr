$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/lib')

require 'gsolr'
require 'rsolr'
require 'benchmark'
require 'ruby-prof'

iters = 20
url   = ARGV[0]
query = ARGV[1]

if url.nil? or query.nil?
  puts "to use, call #{$0} with arguments: solr_url \"query to benchmark\""
  exit
end

Benchmark.bmbm do |x|
  x.report do
    puts "RSolr"
    rsolr = RSolr.connect(:url => url)
    iters.to_i.times do
      rsolr.request("/select", :q => query)
    end
  end

  x.report do
    RubyProf.start
    puts "GSolr"
    gsolr = GSolr.connect(:url => url)
    iters.to_i.times do
      gsolr.request("/select", :q => query)
    end
    @profile = RubyProf.stop
  end
end
puts "----Profiling------------------"
10.times{ puts "" }
printer = RubyProf::FlatPrinter.new(@profile)
printer.print
