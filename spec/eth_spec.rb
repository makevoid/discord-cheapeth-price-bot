require_relative "spec_helper"

describe "ETH" do
  before do
    allow(ETH::Eth).to receive(:blockNumber) {
      12130000
    }
    allow(ETH::Eth).to receive(:getBlockByNumber) {
      block_hash = "0x48f2735efdb798c53328a718fc2201f7e09518a74de7282126460e1311e3064f" # fiy this is actually block#12136913 (note: it doesn't matter for these tests)
      block_data = {
        "hash" => block_hash,
        "transactions" => [],
        "timestamp" => "0x605d0000",
      }
      Web3::Eth::Block.new block_data
    }
  end

  let (:eth) { ETH.new }

  specify "gets latest block number" do
    mocked_block = {
      id:   "0x48f2735efdb798c53328a718fc2201f7e09518a74de7282126460e1311e3064f",
      num:  12130000,
      time: "0x605d0000",
    }
    ETH.block_latest.should == mocked_block
  end

end
