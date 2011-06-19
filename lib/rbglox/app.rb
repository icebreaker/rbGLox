# Semi-abstract Application Class
class RBGLox::App < RBGLox::Window
  # Constructor
  def initialize
    super
    yield self
  end
end

