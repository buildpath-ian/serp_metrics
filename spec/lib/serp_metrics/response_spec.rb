require 'spec_helper'

describe SerpMetrics::Response do
  it "provides accessors for status" do
    instance = described_class.new
    instance.status = 'success'
    instance.status.should == 'success'
  end
end
