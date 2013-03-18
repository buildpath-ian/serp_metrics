require 'spec_helper'

describe SerpMetrics do
  describe ".client" do
    it "returns an instance of SerpMetrics::Client" do
      described_class.client.should be_instance_of(SerpMetrics::Client)
    end

    it "caches client" do
      old_client = described_class.client
      described_class.client.should be_equal(old_client)
    end
  end
end
