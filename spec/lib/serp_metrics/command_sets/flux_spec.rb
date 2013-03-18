require 'spec_helper'

describe SerpMetrics::CommandSets::Flux, :vcr do
  before do
    api_configuration = YAML.load_file('spec/api_credentials.yml')
    @client = SerpMetrics.client.configure do |client|
      client.key = api_configuration['key']
      client.secret = api_configuration['secret']
    end
  end

  describe "flux" do
    it "fetches flux trend" do
      response = @client.flux.flux('google_en-us')
      response['data'].should be_instance_of(Hash)
      trend = response['data'].first
      trend.should be_instance_of(Array)
      trend.length.should == 2
      trend[0].should be_instance_of(String)
      trend[1].should be_instance_of(Fixnum)
    end
  end
end
