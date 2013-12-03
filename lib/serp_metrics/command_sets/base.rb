require 'httpclient'

module SerpMetrics
  module CommandSets
    class Base
      attr_accessor :client

      def initialize(client)
        self.client = client
      end

      protected

      def transact(method, path, options = {})
        signature_hash = client.send(:generate_signature_hash)

        query = signature_hash
        query = query.merge(:params => options.to_json) unless options.empty?

        res = case method
        when :get
          HTTPClient.get(SerpMetrics::API_URI + path, {
            :query => (to_query(query) unless query.empty?)
          })
        when :post
          inner_res = HTTPClient.post(SerpMetrics::API_URI + path, {
            :body => (to_query(query) unless query.empty?)
          })

          if inner_res.redirect?
            inner_res = HTTPClient.get(inner_res.http_header['Location'].first)
          end

          inner_res
        end

        JSON.parse(res.body).merge({'raw'=>res.body})
      end

      private

      def to_query(query)
        URI.encode_www_form(query)
      end
    end
  end
end
