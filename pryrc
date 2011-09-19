require 'rubygems'
begin
  require 'active_support/core_ext'
rescue LoadError; end

# Toy methods to play with.
# Stolen from https://gist.github.com/807492
class Array
  def self.toy(n=10,&block)
    block_given? ? Array.new(n,&block) : Array.new(n) {|i| i+1}
  end
end

class Hash
  def self.toy(n=10)
    Hash[Array.toy(n).zip(Array.toy(n){|c| (96+(c+1)).chr})]
  end
end