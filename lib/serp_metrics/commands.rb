module SerpMetrics
  module Commands
    def keywords
      @keywords ||= SerpMetrics::CommandSets::Keywords.new(self)
    end

    def account
      @account ||= SerpMetrics::CommandSets::Account.new(self)
    end

    def priorities
      @priorities ||= SerpMetrics::CommandSets::Priorities.new(self)
    end

    def flux
      @flux ||= SerpMetrics::CommandSets::Flux.new(self)
    end

    def engines
      @engines ||= SerpMetrics::CommandSets::Engines.new(self)
    end
  end
end
