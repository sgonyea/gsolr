$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'json'

module GSolr
  autoload :Message,    'gsolr/message'
  autoload :Client,     'gsolr/client'
  autoload :Connection, 'gsolr/connection'

  module Connectable
    def connect(opts={})
      Client.new Connection::NetHttp.new(opts)
    end
  end
  extend Connectable

  # A module that contains string related methods
  module Char
    # escape - from the solr-ruby library
    # GSolr.escape('asdf')
    # backslash everything that isn't a word character
    def escape(value)
      value.gsub(/(\W)/, '\\\\\1')
    end
  end

  # send the escape method into the Connection class ->
  # solr = GSolr.connect
  # solr.escape('asdf')
  GSolr::Client.send(:include, Char)

  # bring escape into this module (GSolr) -> GSolr.escape('asdf')
  extend Char

  # RequestError is a common/generic exception class used by the adapters
  class RequestError < RuntimeError
  end
end
