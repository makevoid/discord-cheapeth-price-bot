class Hash
  alias :f :fetch
end

class Array
  alias :f :fetch
end

class String
  def remove_trailing_zeroes
    sub /0*$/, ''
  end
end
