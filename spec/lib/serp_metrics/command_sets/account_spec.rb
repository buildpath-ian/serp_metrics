require 'spec_helper'

describe SerpMetrics::CommandSets::Account, :vcr do
  before do
    api_configuration = YAML.load_file('spec/api_credentials.yml')
    @client = SerpMetrics.client.configure do |client|
      client.key = api_configuration['key']
      client.secret = api_configuration['secret']
    end
  end

  describe "credit" do
    it "fetches credit information" do
      response = @client.account.credit
      response['status'].should == 'ok'
      response['data'].should be_instance_of(Hash)
      response['data']['serp_credit'].should_not be_nil
    end
  end

  describe "time" do
    it "fetches time" do
      response = @client.account.time
      response['request_time'].should_not be_nil
    end
  end
end
