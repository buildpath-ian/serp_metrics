module SerpMetrics
  module CommandSets
    class Account < Base
      def credit
        transact(:post, '/users/credit')
      end

      def time
        transact(:post, '/users/time')
      end
    end
  end
end
