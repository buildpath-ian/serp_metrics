require 'spec_helper'

describe SerpMetrics::CommandSets::Queues::Delayed, :vcr do
  before do
    api_configuration = YAML.load_file('spec/api_credentials.yml')
    @client = SerpMetrics.client.configure do |client|
      client.key = api_configuration['key']
      client.secret = api_configuration['secret']
    end
  end

  describe "add" do
    context "without location" do
      it "adds delayed" do
        response = @client.delayed.add("restaurants", ['google_en-us'])
        response['status'].should == 'ok'

        delayed = response['data'].first
        delayed['phrase'].should == "restaurants"
        delayed['engine_code'].should == 'google_en-us'
        delayed['location'].should be_nil
        delayed['delayed_id'].should_not be_empty
      end
    end

    context "with location" do
      it "adds delayed" do
        response = @client.delayed.add("restaurants", ['google_en-us'], "Nashville")
        response['status'].should == 'ok'

        delayed = response['data'].first
        delayed['phrase'].should == "restaurants"
        delayed['engine_code'].should == 'google_en-us'
        delayed['location'].should == "Nashville"
        delayed['delayed_id'].should_not be_empty
      end
    end
  end

  describe "get" do
    it "checks delayed" do
      response = @client.delayed.add("restaurants", ['google_en-us'])

      delayed = response['data'].first
      delayed_id = delayed['delayed_id']

      response = @client.delayed.get(delayed_id)
      response['status'].should_not be_nil
    end
  end
end
