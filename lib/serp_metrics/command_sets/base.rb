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
        return HTTPClient.get(path,
          {:query => (to_query(query) unless query.empty?)}
          ).body unless EM.reactor_thread?
        f = Fiber.current
        http = EventMachine::HttpRequest.new(path).get(:query => query)
        http.errback {f.resume(http.response)}
        http.callback {f.resume(http.response)}
        return Fiber.yield
      end

      def post path, query
        return HTTPClient.post(path, 
          {:body => (to_query(query) unless query.empty?)}
          ).body unless EM.reactor_running?
        f = Fiber.current
        http = EventMachine::HttpRequest.new(path).post(:body => query)
        http.errback {f.resume(http.response)}
        http.callback {f.resume(http.response)}
        return Fiber.yield
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

        JSON.parse(body).merge({'raw'=>body})
      end

      private

      def to_query(query)
        URI.encode_www_form(query)
      end
    end
  end
end
