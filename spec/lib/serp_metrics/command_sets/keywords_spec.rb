require 'spec_helper'

describe SerpMetrics::CommandSets::Keywords, :vcr do
  before do
    api_configuration = YAML.load_file('spec/api_credentials.yml')
    @client = SerpMetrics.client.configure do |client|
      client.key = api_configuration['key']
      client.secret = api_configuration['secret']
    end
  end

  after do
    response = SerpMetrics.client.keywords.all
    response['data'].each do |keyword_id, keyword_details|
      SerpMetrics.client.keywords.remove(keyword_id)
    end

    # Fail if there are remaining keywords after attempt to remove them.
    response = SerpMetrics.client.keywords.all
    response['data'].should be_empty
  end

  describe "add" do
    it "adds keyword" do
      response = @client.keywords.add("restaurants", ['google_en-us'])
      response['status'].should == 'ok'

      keyword = response['data']
      keyword['keyword'].should == "restaurants"
      keyword['engines'].should == ['google_en-us']
      keyword['keyword_id'].should_not be_empty
    end
  end

  describe "remove" do
    before do
      response = @client.keywords.add("restaurants", ['google_en-us'])
      @keyword_id = response['data']['keyword_id']
    end

    it "removes keyword" do
      response = @client.keywords.remove(@keyword_id)
      response['status'].should == 'ok'
      keyword = response['data'].first
      keyword['status'].should == 'ok'

      # Verify that there is nothing left to remove.
      response = @client.keywords.remove(@keyword_id)
      response['status'].should == 'ok'
      keyword = response['data'].first
      keyword['status'].should == 'failed'
    end
  end

  describe "check" do
    before do
      response = @client.keywords.add("restaurants", ['google_en-us'])
      @keyword_id = response['data']['keyword_id']
    end

    it "retrieves checks" do
      response = @client.keywords.check(@keyword_id, 'google_en-us')
      response['data'].should_not be_empty
      response['data']['checks'].should be_instance_of(Hash)
    end
  end

  describe "serp" do
    it "retrieves serp for check" do
      response = @client.keywords.serp("03bcc63a-dc00-4a41-8010-4fc3346e85b5")
      response['status'].should_not be_empty
    end
  end

  describe "all" do
    before do
      @client.keywords.add("restaurants", ['google_en-us'])
    end

    it "retrieves keywords" do
      response = @client.keywords.all

      response['status'].should == 'ok'
      keyword = response['data'].first
      keyword[0].should_not be_empty
      keyword[1]['phrase'].should == "restaurants"
      keyword[1]['engines'].should == ['google_en-us']
    end
  end
end
