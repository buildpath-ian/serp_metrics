module SerpMetrics
  module Commands
    def keywords
      @keywords ||= SerpMetrics::CommandSets::Keywords.new(self)
    end

    def account
      @account ||= SerpMetrics::CommandSets::Account.new(self)
    end

    def delayed
      @delayed ||= SerpMetrics::CommandSets::Queues::Delayed.new(self)
    end

    def priority
      @priority ||= SerpMetrics::CommandSets::Queues::Priority.new(self)
    end

    def flux
      @flux ||= SerpMetrics::CommandSets::Flux.new(self)
    end

    def engines
      @engines ||= SerpMetrics::CommandSets::Engines.new(self)
    end
  end
end
