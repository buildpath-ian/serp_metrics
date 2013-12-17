module SerpMetrics
  module CommandSets
    class Keywords < Base
      def add(keyword, engines)
        transaction_options = {
          :keyword => keyword,
          :engines => engines
        }
        transact(:post, '/keywords/add', transaction_options)
      end

      def remove(keyword_id)
        transaction_options = {
          :keyword_id => keyword_id,
        }
        transact(:post, '/keywords/delete', transaction_options)
      end

      def check(keyword_id, engine, limit = 10)
        transaction_options = {
          :keyword_id => keyword_id,
          :engine => engine,
          :limit => limit
        }
        transact(:post, '/keywords/check', transaction_options)
      end

      def serp(check_id, domain = nil)
        transaction_options = {
          :check_id => check_id,
          :domain => domain
        }
        transact(:post, '/keywords/serp', transaction_options)
      end

      def all page=1, limit=100
        transaction_options = {
          :page => page,
          :limit => limit
        }
        transact(:post, '/keywords/all', transaction_options)
      end
    end
  end
end
