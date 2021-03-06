# GSolr

A simple, extensible Ruby client for the Solr interface.  Capable of talking to Solr and to Riak.

## Installation:
    sudo gem install gsolr

## Example:
    require 'rubygems'
    require 'gsolr'
    solr      = GSolr.connect :url => "http://solrserver.com"
    
    # send a request to /select
    response  = gsolr.select :q=>'*:*'
    
    # send a request to a custom request handler; /catalog
    response  = gsolr.request '/catalog', :q=>'*:*'
    
    # alternative to above:
    response  = gsolr.catalog :q=>'*:*'

## Querying
Use the #select method to send requests to the /select handler:

    response  = solr.select {
                  :q=>'washington',
                  :start=>0,
                  :rows=>10
                }

The params sent into the method are sent to Solr as-is. The one exception is if a value is an array. When an array is used, multiple parameters *with the same name* are generated for the Solr query. Example:
    
    solr.select {
      :q  =>  'roses',
      :fq =>  ['red', 'violet']
    }

The above statement generates this Solr query:
    
    .../?q=roses&fq=red&fq=violet

Use the #request method for a custom request handler path:

    response = solr.request '/documents', :q=>'test'

A shortcut for the above example use a method call instead:

    response = solr.documents :q=>'test'


## Updating Solr
Updating uses native Ruby structures. Hashes are used for single documents and arrays are used for a collection of documents (hashes). These structures get turned into simple XML "messages". Raw XML strings can also be used.

Raw XML via  #update

    solr.update '</commit>'
    solr.update '</optimize>'

Single document via #add

    solr.add {
      :id     =>  1,
      :price  =>  1.00
    }

Multiple documents via #add

    documents = [{
        :id     =>  1,
        :price  =>  1.00
      }, {
        :id     =>  2,
        :price  =>  10.50
    }]
    
    solr.add documents

When adding, you can also supply "add" xml element attributes and/or a block for manipulating other "add" related elements (docs and fields) when using the #add method:
    
    add_doc   = {:id=>1, :price=>1.00}
    add_attr  = {:allowDups=>false, :commitWithin=>10.0}
    
    solr.add(add_doc, add_attr) do |doc|
      # boost each document
      doc.attrs[:boost] = 1.5
      # boost the price field:
      doc.field_by_name(:price).attrs[:boost] = 2.0
    end

Delete by id

    solr.delete_by_id 1

or an array of ids

    solr.delete_by_id [1, 2, 3, 4]

Delete by query:

    solr.delete_by_query 'price:1.00'

Delete by array of queries

    solr.delete_by_query ['price:1.00', 'price:10.00']

Commit & optimize shortcuts

    solr.commit
    solr.optimize

## Response Formats
The default response format is Ruby. When the :wt param is set to :ruby, the response is eval'd resulting in a Hash. You can get a raw response by setting the :wt to "ruby" - notice, the string -- not a symbol. GSolr will eval the Ruby string ONLY if the :wt value is :ruby. All other response formats are available as expected, :wt=>'xml' etc..

### Evaluated Ruby (default)

    solr.select(:wt=>:ruby) # notice :ruby is a Symbol

### Raw Ruby

    solr.select(:wt=>'ruby') # notice 'ruby' is a String

### XML:

    solr.select(:wt=>:xml)

### JSON:

    solr.select(:wt=>:json)

You can access the original request context (path, params, url etc.) by calling the #raw method:

    response = solr.select :q=>'*:*'

    response.raw[:status_code]
    response.raw[:body]
    response.raw[:url]

The raw is a hash that contains the generated params, url, path, post data, headers etc., very useful for debugging and testing.

## Related Resources & Projects
* The Apache Solr project
  * [Solr](http://lucene.apache.org/solr/)
* The original Solr Ruby Gem
  * [solr-ruby](http://wiki.apache.org/solr/solr-ruby)
* The RSolr Gem, from which this was hijacked
  * [RSolr](https://github.com/mwmitchell/rsolr)

## Note on Patches/Pull Requests
* Fork the project.
* Add tests for your contribution.
* Write your contribution.
* Commit only that contribution. Changes to rakefile, version, or history should be done in a respective commit.
* Send a pull request.

## Contributors (to the RSolr project, who therefore contributed to this)
* mperham
* Mat Brown
* shairontoledo
* Matthew Rudy
* Fouad Mardini