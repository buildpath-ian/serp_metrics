module SerpMetrics
  module CommandSets
    class Engines < Base
      def codes
        transact(:post, '/engines/codes')
      end
    end
  end
end
