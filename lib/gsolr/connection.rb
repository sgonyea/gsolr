$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'uri'

module GSolr
  module Connection
    autoload :NetHttp,      'connection/net_http'
    autoload :Streamly,     'connection/streamly'
    autoload :Utils,        'connection/utils'
    autoload :Requestable,  'connection/requestable'
  end
end
