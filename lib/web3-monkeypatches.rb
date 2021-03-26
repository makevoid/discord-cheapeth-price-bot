# web3-eth monkeypatch - add ETH_RPC_PATH

module Web3
  module Eth
    class Rpc

      def initialize host: DEFAULT_HOST, port: DEFAULT_PORT, connect_options: DEFAULT_CONNECT_OPTIONS
        @client_id = Random.rand 10000000

        # add RPC path
        rpc_path = "/rpc"
        rpc_path = ETH_RPC_PATH if defined? ETH_RPC_PATH
        @uri = URI((connect_options[:use_ssl] ? 'https' : 'http')+ "://#{host}:#{port}#{rpc_path}")
        @connect_options = connect_options

        @eth = Ethereum.new self
      end

    end
  end
end
