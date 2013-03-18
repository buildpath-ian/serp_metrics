module SerpMetrics
  class Client
    include SerpMetrics::Commands

    attr_accessor :key, :secret

    def initialize(key = nil, secret = nil)
      self.key = key
      self.secret = secret
    end

    def configure
      yield self
      self
    end

    protected

    def generate_signature(timestamp = nil)
      Base64.strict_encode64(OpenSSL::HMAC.digest('sha256', secret, timestamp.to_i.to_s))
    end

    def generate_signature_hash(timestamp = nil)
      timestamp ||= Time.now.utc
      signature = generate_signature(timestamp)

      {
        :key => key,
        :ts => timestamp.to_i.to_s,
        :auth => signature
      }
    end
  end
end
