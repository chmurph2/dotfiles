IRB.conf[:PROMPT_MODE] = :SIMPLE

require 'rubygems'
begin
  require 'active_support/core_ext'
  require 'sketches'
  require 'irb/completion'
  require 'irb/ext/save-history'
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

# adds readline functionality
IRB.conf[:USE_READLINE] = true
# auto indents suites
IRB.conf[:AUTO_INDENT] = true
# where history is saved
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"
# how many lines to save
IRB.conf[:SAVE_HISTORY] = 1000

# don't save duplicates
IRB.conf[:AT_EXIT].unshift Proc.new {
  no_dups = []
  Readline::HISTORY.each_with_index { |e,i|
    begin
      no_dups << e if Readline::HISTORY[i] != Readline::HISTORY[i+1]
    rescue IndexError
    end
  }
  Readline::HISTORY.clear
  no_dups.each { |e|
    Readline::HISTORY.push e
  }
}