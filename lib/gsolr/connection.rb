require 'uri'

module GSolr
  module Connection
    autoload :NetHttp,      'gsolr/connection/net_http'
    autoload :Utils,        'gsolr/connection/utils'
    autoload :Requestable,  'gsolr/connection/requestable'
  end
end