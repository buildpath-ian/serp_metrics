module SerpMetrics
  module CommandSets
    class Flux < Base
      def flux(engine_code, type = 'daily')
        transaction_options = {
          :engine_code => engine_code,
          :type => type
        }
        transact(:post, '/flux/trend', transaction_options)
      end
    end
  end
end
