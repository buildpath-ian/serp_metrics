# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'serp_metrics/version'

Gem::Specification.new do |gem|
  gem.name          = "serp_metrics"
  gem.version       = SerpMetrics::VERSION
  gem.authors       = ["Kristina Lim"]
  gem.email         = ["kristinalim.ph@gmail.com"]
  gem.description   = %q{Ruby interface to the SERP Metrics API}
  gem.summary       = %q{Ruby interface to the SERP Metrics API}
  gem.homepage      = "https://github.com/wearetribe/serp_metrics.git"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'multi_json', '~> 1.3'
  gem.add_runtime_dependency 'httpclient', '~> 2.3'
end
