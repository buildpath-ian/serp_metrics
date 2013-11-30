# SerpMetrics

Ruby interface to the [SERP Metrics](http://serpmetrics.com) API

## Installation

Add this line to your application's Gemfile:

    gem 'serp_metrics'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install serp_metrics

## Usage

    SerpMetrics.client.configure do |client|
      client.key = 'API_KEY'
      client.secret = 'API_SECRET'
    end

    SerpMetrics.client.account.credit
    SerpMetrics.client.account.time

    SerpMetrics.client.engines.codes

    SerpMetrics.client.flux.flux('google_en-us')

    SerpMetrics.client.keywords.add("restaurants", ['google_en-us'])
    SerpMetrics.client.keywords.remove(keyword_id)
    SerpMetrics.client.keywords.check(keyword_id, ['google_en-us'])
    SerpMetrics.client.keywords.serp(check_id)
    SerpMetrics.client.keywords.all

    SerpMetrics.client.delayed.add("restaurants", ['google_en-us'])
    SerpMetrics.client.delayed.add("restaurants", ['google_en-us'], "Nashville")
    SerpMetrics.client.delayed.get(delayed_id)

    SerpMetrics.client.priority.add("restaurants", ['google_en-us'])
    SerpMetrics.client.priority.add("restaurants", ['google_en-us'], "Nashville")
    SerpMetrics.client.priority.get(priority_id)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
