module Cryptoexchange::Exchanges
  module CoinExchange
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::CoinExchange::Market::API_URL}/getmarkets"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output['result'].map do |market|
            Cryptoexchange::Models::MarketPair.new({
              base: market['MarketAssetCode'],
              target: market['BaseCurrencyCode'],
              inst_id: market['MarketID'],
              market: CoinExchange::Market::NAME
            }) if market['Active']
          end.compact
        end
      end
    end
  end
end
