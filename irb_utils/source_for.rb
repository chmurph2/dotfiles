# Usage: source_for(SomeClass, :method_name)
# => Opens to the method using Sublime Text
# Source: http://pragmaticstudio.com/blog/2013/2/13/view-source-ruby-methods
def source_for(object, method_sym)
  if object.respond_to?(method_sym, true)
    method = object.method(method_sym)
  elsif object.is_a?(Module)
    method = object.instance_method(method_sym)
  end
  location = method.source_location
  `subl #{location[0]}:#{location[1]}` if location
  location
rescue
  nil
end