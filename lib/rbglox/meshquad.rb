# Quad Mesh Class
class RBGLox::MeshQuad < RBGLox::Mesh
  # Constructor
  def initialize(x=1.0, y=1.0)
		verts = [
      -x, -y, 0.0,
       x, -y, 0.0,
       x,  y, 0.0,
      -x,  y, 0.0 ]

    texs = [
      0.0, 0.0,
      1.0, 0.0,
      1.0, 1.0,
      0.0, 1.0 ]
    
    norms = [
      0.0, 0.0, 1.0,
      0.0, 0.0, 1.0,
      0.0, 0.0, 1.0,
      0.0, 0.0, 1.0 ]

		tris = [
			3, 2, 1,
			3, 1, 0 ]

    super verts, texs, norms, tris
  end
end
