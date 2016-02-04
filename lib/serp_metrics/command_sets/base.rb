require 'eventmachine'
require 'em-http'
require 'fiber'
require 'httpclient'

module SerpMetrics
  module CommandSets
    class Base
      attr_accessor :client

      def initialize(client)
        self.client = client
      end

      private

      def get path, query=nil
        if EM.reactor_thread?
          f = Fiber.current
          http = EventMachine::HttpRequest.new(path).get(:query => query)
          http.errback {f.resume(http.response)}
          http.callback {f.resume(http.response)}
          return Fiber.yield
        else
          return HTTPClient.get(path, {
            :query => (to_query(query) unless query.empty?)
            } ).body
        end
      end

      def post path, query
        if EM.reactor_thread?
          f = Fiber.current
          http = EventMachine::HttpRequest.new(path).post(:body => query)
          http.errback {f.resume(http.response)}
          http.callback {f.resume(http.response)}
          return Fiber.yield
        else
          inner_res = HTTPClient.post(path, {
            :body => (to_query(query) unless query.empty?)
          })
          if inner_res.redirect?
            inner_res = HTTPClient.get(inner_res.http_header['Location'].first)
          end
          return inner_res.body
        end
      end

      protected

      def transact(method, path, options = {})
        signature_hash = client.send(:generate_signature_hash)

        query = signature_hash
        query = query.merge(:params => options.to_json) unless options.empty?

        body = case method
        when :get
          get(SerpMetrics::API_URI + path, query)
        when :post
          post(SerpMetrics::API_URI + path, query)
        end

        begin
          result = JSON.parse(body)
        rescue => e
          result = {'status'=>"error: #{e.message}", 'raw'=>body}
        end
        result
      end

      private

      def to_query(query)
        URI.encode_www_form(query)
      end
    end
  end
end
