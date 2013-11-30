require 'vcr'
require 'webmock'
require 'timecop'

require 'yaml'
require 'serp_metrics'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'

  # vcr
  config.around(:each) do |example|
    vcr_options = example.metadata[:vcr]

    vcr_options = {
      :record => :once,
      :allow_playback_repeats => false
    } unless vcr_options.is_a?(Hash)

    if vcr_options
      vcr_name = example.metadata[:full_description].split(/\s+/, 2).join('/').gsub!(/(.)([A-Z])/,'\1_\2').downcase!.gsub(/[^\w\/]+/, '_')
      VCR.use_cassette(vcr_name, vcr_options, &example)
    else
      WebMock.disable!
      VCR.turned_off(&example)
      WebMock.enable!
    end
  end

  # timecop
  config.before(:each) do
    Timecop.freeze(Time.at(1385796873))
  end

  config.after(:each) do
    Timecop.return
  end
end

api_configuration = YAML.load_file('spec/api_credentials.yml')
VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.ignore_localhost = true
  config.default_cassette_options = {
    :record => :once,
    :allow_playback_repeats => false
  }

  config.filter_sensitive_data('<SERP_METRICS_KEY>') do
    api_configuration['key']
  end

  config.filter_sensitive_data('<SERP_METRICS_KEY_ENCODED>') do
    URI.encode(api_configuration['key'])
  end

  config.filter_sensitive_data('<SERP_METRICS_SECRET>') do
    api_configuration['secret']
  end

  config.filter_sensitive_data('<SERP_METRICS_SECRET_ENCODED>') do
    URI.encode(api_configuration['secret'])
  end
end
