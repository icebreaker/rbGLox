# Cube Mesh Class
class RBGLox::MeshCube < RBGLox::Mesh
  # Constructor
  def initialize(x=1.0, y=1.0, z=1.0, tx=0.0, ty=0.0, tz=0.0)
		verts = [
		-x + tx, -y + ty, -z + tz,
		 x + tx, -y + ty, -z + tz,
		 x + tx,  y + ty, -z + tz,
		-x + tx,  y + ty, -z + tz,
		-x + tx, -y + ty,  z + tz,
		-x + tx,  y + ty,  z + tz,
		 x + tx,  y + ty,  z + tz,
		 x + tx, -y + ty,  z + tz,
		-x + tx, -y + ty, -z + tz,
		-x + tx,  y + ty, -z + tz,
		-x + tx,  y + ty,  z + tz,
		-x + tx, -y + ty,  z + tz,
		 x + tx, -y + ty, -z + tz,
		 x + tx, -y + ty,  z + tz,
		 x + tx,  y + ty,  z + tz,
		 x + tx,  y + ty, -z + tz,
		-x + tx,  y + ty, -z + tz,
		 x + tx,  y + ty, -z + tz,
		 x + tx,  y + ty,  z + tz,
		-x + tx,  y + ty,  z + tz,
		-x + tx, -y + ty, -z + tz,
		-x + tx, -y + ty,  z + tz,
		 x + tx, -y + ty,  z + tz,
		 x + tx, -y + ty, -z + tz]

		norms = [
		 0,  0, -1,
		 0,  0, -1,
		 0,  0, -1,
		 0,  0, -1,
		 0,  0,  1,
		 0,  0,  1,
		 0,  0,  1,
		 0,  0,  1,
		-1,  0,  0,
		-1,  0,  0,
		-1,  0,  0,
		-1,  0,  0,
		 1,  0,  0,
		 1,  0,  0,
		 1,  0,  0,
		 1,  0,  0,
		 0,  1,  0,
		 0,  1,  0,
		 0,  1,  0,
		 0,  1,  0,
		 0, -1,  0,
		 0, -1,  0,
		 0, -1,  0,
		 0, -1,  0 ]

		texs = [
		0, 0,	# 0
		1, 0,	# 1
		1, 1,	# 2
		0, 1,	# 3
		1, 0,	# 4
		1, 1,	# 5
		0, 1,	# 6
		0, 0,	# 7
		1, 0,	# 8
		1, 1,	# 9
		0, 1,	# 10
		0, 0,	# 11
		0, 0,	# 12
		1, 0,	# 13
		1, 1,	# 14
		0, 1,	# 15
		0, 0,	# 16
		1, 0,	# 17
		1, 1,	# 18
		0, 1,	# 19
		0, 1,	# 20
		0, 0,	# 21
		1, 0,	# 22
		1, 1 ]	# 23

		tris = [
		0,	 2,  1,
		0,	 3,  2,
		4,	 6,  5,
		4,	 7,  6,
		8,	10,  9,
		8,	11, 10,
		12, 14, 13,
		12, 15, 14,
		16, 18, 17,
		16, 19, 18,
		20, 22, 21,
		20, 23, 22 ]

    super verts, texs, norms, tris
  end
end
