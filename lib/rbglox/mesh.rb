# Semi-abstract Mesh Class
class RBGLox::Mesh < RBGLox::Resource
  include Gl
 
  # Constructor
  def initialize(verts, texs, norms, tris)
    @id = glGenLists 1
  
    glNewList id, GL_COMPILE
      glPushClientAttrib GL_CLIENT_VERTEX_ARRAY_BIT
  		glEnableClientState GL_VERTEX_ARRAY
	  	glEnableClientState GL_TEXTURE_COORD_ARRAY
		  glEnableClientState GL_NORMAL_ARRAY
		  glVertexPointer 3, GL_FLOAT, 0, verts
		  glNormalPointer GL_FLOAT, 0, norms
      glTexCoordPointer 2, GL_FLOAT, 0, texs
  		glDrawElements GL_TRIANGLES, tris.size, GL_UNSIGNED_INT, tris
      glPopClientAttrib
    glEndList
  end

  # Draw the mesh by calling the internal display list
  def draw
    glCallList id
  end

  # Reload the mesh
  def reload
    # do nothing
  end

  # Free the mesh by destroying the internal display list
  def free
    glDeleteLists id, 1
  end
end
