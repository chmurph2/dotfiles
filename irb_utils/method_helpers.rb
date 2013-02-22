class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end

  # return the methods not present on basic objects.
  def interesting_methods
    (self.methods - Object.instance_methods).sort
  end
end