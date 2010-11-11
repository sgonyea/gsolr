require 'streamly_ffi'

#
# Connection for standard HTTP Solr server
#
module GSolr
  module Connection
    class Streamly

      include GSolr::Connection::Requestable

      def get(path, params={})
        url       = self.build_url path, params
        response  = StreamlyFFI.get url
        create_http_context response, url, path, params
      end

      def post(path, data, params={}, headers={})
        url       = self.build_url path, params
        response  = StreamlyFFI.post url, data, headers
        create_http_context response, url, path, params, data, headers
      end

      def create_http_context(response, url, path, params, data=nil, headers={})
        full_url  = "#{@uri.scheme}://#{@uri.host}"
        full_url += ":#{@uri.port}" if @uri.port
        full_url += url

        return {
          :url          =>  full_url,
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