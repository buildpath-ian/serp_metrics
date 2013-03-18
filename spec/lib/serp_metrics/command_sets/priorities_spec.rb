require 'spec_helper'

describe SerpMetrics::CommandSets::Priorities, :vcr do
  before do
    api_configuration = YAML.load_file('spec/api_credentials.yml')
    @client = SerpMetrics.client.configure do |client|
      client.key = api_configuration['key']
      client.secret = api_configuration['secret']
    end
  end

  describe "add" do
    context "without location" do
      it "adds priority" do
        response = @client.priorities.add("restaurants", ['google_en-us'])
        response['status'].should == 'ok'

        priority = response['data'].first
        priority['phrase'].should == "restaurants"
        priority['engine_code'].should == 'google_en-us'
        priority['location'].should be_nil
        priority['priority_id'].should_not be_empty
      end
    end

    context "with location" do
      it "adds priority" do
        response = @client.priorities.add("restaurants", ['google_en-us'], "Nashville")
        response['status'].should == 'ok'

        priority = response['data'].first
        priority['phrase'].should == "restaurants"
        priority['engine_code'].should == 'google_en-us'
        priority['location'].should == "Nashville"
        priority['priority_id'].should_not be_empty
      end
    end
  end

  describe "get" do
    it "checks priority" do
      response = @client.priorities.add("restaurants", ['google_en-us'])

      priority = response['data'].first
      priority_id = priority['priority_id']

      response = @client.priorities.get(priority_id)
      response['status'].should_not be_nil
    end
  end
end
