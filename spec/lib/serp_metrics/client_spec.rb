require 'spec_helper'

describe SerpMetrics::Client do
  it "provides accessors for key" do
    instance = described_class.new
    instance.key = "61dcaafa-5775-4905-b15a-c0dddb323038"
    instance.key.should == "61dcaafa-5775-4905-b15a-c0dddb323038"
  end

  it "provides accessors for secret" do
    instance = described_class.new
    instance.secret = "4d5c3bb1-b274-4150-801b-7722d3427da1"
    instance.secret.should == "4d5c3bb1-b274-4150-801b-7722d3427da1"
  end

  describe "configuration" do
    it "performs block on client" do
      instance = described_class.new
      instance.configure do |client|
        client.key = "acf08654-4694-4158-8b38-823233844d85"
        client.secret = "eb9bb368-7c1f-41c0-afa1-c03fbfc2493b"
      end
      instance.key.should == "acf08654-4694-4158-8b38-823233844d85"
      instance.secret.should == "eb9bb368-7c1f-41c0-afa1-c03fbfc2493b"
    end
  end
end
