# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gsolr/version"

Gem::Specification.new do |s|
  s.name        = "gsolr"
  s.version     = Gsolr::VERSION
  s.authors     = ["Scott Gonyea"]
  s.email       = ["me@sgonyea.com"]
  s.homepage    = "http://rubygems.org/gems/gsolr"
  s.summary     = %q{Generic Solr Client}
  s.description = %q{This is a generic solr client, capable of talking to Solr, as well as Riak}

  s.rubyforge_project = "gsolr"

  s.add_dependency('json')
  s.add_dependency('streamly_ffi')

  s.add_development_dependency "rspec"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
end
