# The Solr::Message::Generator class is the XML generation module for sending updates to Solr.
module GSolr
  module Message
    autoload :Document,   'gsolr/message/document'
    autoload :Field,      'gsolr/message/field'
    autoload :Generator,  'gsolr/message/generator'
  end
end