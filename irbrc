IRB.conf[:PROMPT_MODE] = :SIMPLE

class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

require 'rubygems'
begin
  require 'active_support/core_ext'
  require 'flyrb'
rescue LoadError; end

