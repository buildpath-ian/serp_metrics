require 'spec_helper'

describe SerpMetrics::Client do
  before do
    @client = described_class.new
  end

  describe ".keywords" do
    it "assigns client for command set" do
      @client.keywords.client.should be_equal(@client)
    end

    it "caches command set for client" do
      old_command_set = @client.keywords
      @client.keywords.should be_equal(old_command_set)
    end
  end

  describe ".account" do
    it "assigns client for command set" do
      @client.account.client.should be_equal(@client)
    end

    it "caches command set for client" do
      old_command_set = @client.account
      @client.account.should be_equal(old_command_set)
    end
  end

  describe ".delayed" do
    it "assigns client for command set" do
      @client.delayed.client.should be_equal(@client)
    end

    it "caches command set for client" do
      old_command_set = @client.delayed
      @client.delayed.should be_equal(old_command_set)
    end
  end

  describe ".priority" do
    it "assigns client for command set" do
      @client.priority.client.should be_equal(@client)
    end

    it "caches command set for client" do
      old_command_set = @client.priority
      @client.priority.should be_equal(old_command_set)
    end
  end

  describe ".flux" do
    it "assigns client for command set" do
      @client.flux.client.should be_equal(@client)
    end

    it "caches command set for client" do
      old_command_set = @client.flux
      @client.flux.should be_equal(old_command_set)
    end
  end

  describe ".engines" do
    it "assigns client for command set" do
      @client.engines.client.should be_equal(@client)
    end

    it "caches command set for client" do
      old_command_set = @client.engines
      @client.engines.should be_equal(old_command_set)
    end
  end
end
