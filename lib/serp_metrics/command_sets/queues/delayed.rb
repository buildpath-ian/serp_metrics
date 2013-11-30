module SerpMetrics
  module CommandSets
    module Queues
      class Delayed < SerpMetrics::CommandSets::Queues::Base
        def queue_name
          :delayed
        end

        def item_id_parameter
          :delayed_id
        end
      end
    end
  end
end
