# Texture Class
class RBGLox::Texture < RBGLox::Resource
  include Glfw
  include Gl

  attr_accessor :filename, :mipmaps

  # Constructor
  def initialize(filename, mipmaps=false)
    @filename = filename
    @mipmaps = mipmaps
    @id = glGenTextures(1)[0]

    reload
  end

  # Bind the Texture
  def bind(unit=0)
    glActiveTexture(GL_TEXTURE0 + unit)
    glBindTexture GL_TEXTURE_2D, id
  end

  # Release the Texture
  def release(unit=0)
    glActiveTexture(GL_TEXTURE0 + unit)
    glBindTexture GL_TEXTURE_2D, 0
  end

  # Reload the Texture
  def reload(unit=0)
    bind unit

    glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE
    glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE
    glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR
    glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR

    if mipmaps:
      glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_NEAREST
      glfwLoadTexture2D filename, GLFW_BUILD_MIPMAPS_BIT
    else
      glfwLoadTexture2D filename, 0
    end

    release unit
  end

  # Free the Texture
  def free
    glDeleteTextures [id]
  end
end
