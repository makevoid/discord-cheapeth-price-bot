class ETH

  Eth = WEB3.eth

  def block_number_get
    Eth.blockNumber
  end

  def block_get(block_number:)
    Eth.getBlockByNumber block_number
  end

  def block_latest
    block_num   = block_number_get
    block_num   = block_num.to_i
    block       = block_get block_number: block_num
    block_hash  = block.hash
    timestamp   = block.timestamp
    # TODO: consider to add miner,
    {
      id:   block_hash,
      num:  block_num,
      time: timestamp,
    }
  end

  def self.block_latest
    new.block_latest
  end

  private

  # misc methods - currently unused

  def validate_block_hash(hash)
    raise "HexBlockHashValueFormatError" if !hash.is_a?(String) || hash[0..1] != "0x" || hash.size != 66
  end

end
