module SerpMetrics
  module CommandSets
    module Queues
      class Base < SerpMetrics::CommandSets::Base
        def add(keyword, engines, location = nil)
          transaction_options = {
            :keyword => keyword,
            :engines => engines
          }
          unless location.nil?
            transaction_options[:location] = location
          end
          transact(:post, "/#{queue_name}/add", transaction_options)
        end

        def get(item_id)
          transaction_options = {
            item_id_parameter => item_id
          }
          transact(:post, "/#{queue_name}/status", transaction_options)
        end
      end
    end
  end
end
