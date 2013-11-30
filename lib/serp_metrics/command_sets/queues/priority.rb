module SerpMetrics
  module CommandSets
    module Queues
      class Priority < SerpMetrics::CommandSets::Queues::Base
        def queue_name
          :priority
        end

        def item_id_parameter
          :priority_id
        end
      end
    end
  end
end
