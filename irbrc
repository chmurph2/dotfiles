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

