# Abstract Resource Class
class RBGLox::Resource
  attr_reader :id

  # Reload resource
  def reload
    raise NotImplementedError
  end

  # Free resource
  def free
    raise NotImplementedError
  end
end
