IRB.conf[:PROMPT_MODE] = :SIMPLE

require 'rubygems'
begin
  require 'active_support/core_ext'
  require 'flyrb'
rescue LoadError; end

class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end

  # return the methods not present on basic objects.
  def interesting_methods
    (self.methods - Object.instance_methods).sort
  end
end

# Toys methods to play with.
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
