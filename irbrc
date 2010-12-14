IRB.conf[:PROMPT_MODE] = :SIMPLE

class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

require 'rubygems'
begin
  # require 'utility_belt'
  require 'flyrb'
rescue LoadError
  # warn "Missing utility_belt gem"
  warn "Missing flyrb gem (gem install flyrb --pre)"
end

