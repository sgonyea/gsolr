require 'streamly_ffi'

#
# Connection for standard HTTP Solr server
#
module GSolr
  module Connection
    class Streamly

      include GSolr::Connection::Requestable

      def connection
        @connection ||= StreamlyFFI.connect
      end

      def escape(_string)
        self.connection.escape(_string)
      end

      def get(path, params={})
        url       = self.build_url path, params
        response  = connection.get url
        create_http_context response, url, path, params
      end

      def post(path, data, params={}, headers={})
        url       = self.build_url path, params
        response  = connection.post url, data, headers
        create_http_context response, url, path, params, data, headers
      end

      # send a request to the connection
      # request '/select', :q=>'*:*'
      #
      # request '/update', {:wt=>:xml}, '</commit>'
      # 
      # force a post where the post body is the param query
      # request '/update', "<optimize/>", :method=>:post
      #
      def request(path, params={}, *extra)
        opts = extra[-1].kind_of?(Hash) ? extra.pop : {}
        data = extra[0]
        # force a POST, use the query string as the POST body
        if opts[:method] == :post and data.to_s.empty?
          http_context = self.post(path, hash_to_query(params), {}, {'Content-Type' => 'application/x-www-form-urlencoded'})
        else
          if data
            # standard POST, using "data" as the POST body
            http_context = self.post(path, data, params, {"Content-Type" => 'text/xml; charset=utf-8'})
          else
            # standard GET
            http_context = self.get(path, params)
          end
        end
        return http_context
      end

      def create_http_context(response, url, path, params, data=nil, headers={})
        return {
          :url          =>  url,
          :body         =>  response,
          :path         =>  path,
          :params       =>  params,
          :data         =>  data,
          :headers      =>  headers
        }
      end

      # accepts a path/string and optional hash of query params
      def build_url(path, params={})
        full_path = @uri.path + path
        full_url  = "#{@uri.scheme}://#{@uri.host}"
        full_url += ":#{@uri.port}" if @uri.port
        full_url += super(full_path, params, @uri.query)
      end

    end # class NetHttp
  end # module Connection
end # module GSolr