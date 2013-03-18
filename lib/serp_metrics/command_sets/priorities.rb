module SerpMetrics
  module CommandSets
    class Priorities < Base
      def add(keyword, engines, location = nil)
        transaction_options = {
          :keyword => keyword,
          :engines => engines
        }
        unless location.nil?
          transaction_options[:location] = location
        end
        transact(:post, '/priority/add', transaction_options)
      end

      def get(priority_id)
        transaction_options = {
          :priority_id => priority_id
        }
        transact(:post, '/priority/status', transaction_options)
      end
    end
  end
end
