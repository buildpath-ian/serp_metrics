require 'spec_helper'

describe SerpMetrics::CommandSets::Engines, :vcr do
  before do
    api_configuration = YAML.load_file('spec/api_credentials.yml')
    @client = SerpMetrics.client.configure do |client|
      client.key = api_configuration['key']
      client.secret = api_configuration['secret']
    end
  end

  describe "codes" do
    it "fetches search engine codes" do
      response = @client.engines.codes
      response['status'].should == 'ok'
      response['data'].should be_instance_of(Array)
      response['data'].should_not be_empty
      response['data'][0]['engine_code'].should_not be_empty
      response['data'][0]['name'].should_not be_empty
    end
  end
end
