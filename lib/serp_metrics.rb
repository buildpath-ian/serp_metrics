require 'base64'
require 'openssl'
require 'json'

require 'serp_metrics/version'
require 'serp_metrics/response'
require 'serp_metrics/command_sets/base'
require 'serp_metrics/command_sets/account'
require 'serp_metrics/command_sets/engines'
require 'serp_metrics/command_sets/flux'
require 'serp_metrics/command_sets/keywords'
require 'serp_metrics/command_sets/priorities'
require 'serp_metrics/commands'
require 'serp_metrics/client'

module SerpMetrics
  API_URI = 'http://api.serpmetrics.com'
  USER_AGENT = 'SERPMetrics Ruby Library'

  class << self
    def client
      @client ||= Client.new
    end
  end
end
