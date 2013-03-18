require 'spec_helper'

describe SerpMetrics do
  it "has version" do
    described_class::VERSION.should be_instance_of(String)
    described_class::VERSION.should_not be_empty
  end
end
